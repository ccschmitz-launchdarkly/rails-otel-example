require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/all'
require 'opentelemetry/exporter/otlp'
require_relative '../../lib/trace_logger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'rails-otel-example'
  c.use_all
end

# Send logs to LaunchDarkly
Rails.logger = TraceLogger.new(STDOUT)
