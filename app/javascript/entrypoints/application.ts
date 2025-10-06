// Main application entry point
import "../../assets/stylesheets/application.css";
import Rails from "@rails/ujs";
import { initializeLaunchDarkly } from "../launchdarkly";

// Start Rails UJS for remote: true AJAX support
Rails.start();

// Initialize LaunchDarkly when DOM is ready
document.addEventListener("DOMContentLoaded", () => {
  initializeLaunchDarkly();
});

console.log("Vite application loaded");
