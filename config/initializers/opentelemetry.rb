require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/all'
require 'opentelemetry/exporter/otlp'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'rails-otel-example'
  c.use_all
end

# TODO: Add config for sending logs to LaunchDarkly
