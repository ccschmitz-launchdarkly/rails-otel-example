// LaunchDarkly Client SDK initialization with Observability and SessionReplay plugins
import * as LDClient from "launchdarkly-js-client-sdk";
import Observability from "@launchdarkly/observability";
import SessionReplay from "@launchdarkly/session-replay";

export function initializeLaunchDarkly(): void {
  // Check if LaunchDarkly SDK is loaded
  if (!LDClient) {
    console.error("LaunchDarkly SDK not loaded");
    return;
  }

  // Get client-side ID from meta tag
  const clientSideID = document.querySelector<HTMLMetaElement>(
    'meta[name="launchdarkly-client-id"]'
  );
  if (!clientSideID || !clientSideID.content) {
    console.error("LaunchDarkly client ID not found in meta tags");
    return;
  }

  // Simple anonymous user context
  const user = {
    key: "anonymous-" + Math.random().toString(36).substring(7),
    anonymous: true,
  };

  // Initialize LaunchDarkly client with Observability and SessionReplay plugins
  const ldClient = LDClient.initialize(clientSideID.content, user, {
    plugins: [
      new Observability({
        serviceName: "rails-otel-client",
        tracingOrigins: true,
        networkRecording: {
          enabled: true,
          recordHeadersAndBody: true,
        },
      }),
      new SessionReplay({
        tracingOrigins: true,
        privacySetting: "none",
      }),
    ],
  });

  // Wait for client to be ready
  ldClient
    .waitForInitialization()
    .then(() => {
      console.log(
        "LaunchDarkly client initialized with observability and session replay plugins"
      );

      // Store client globally for access from other scripts
      (window as any).ldClient = ldClient;
    })
    .catch((error: Error) => {
      console.error("LaunchDarkly initialization error:", error);
    });
}

export default { initializeLaunchDarkly };
