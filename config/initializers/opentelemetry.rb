# frozen_string_literal: true

require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/all'
require_relative '../../lib/trace_logger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'rails-otel-example'
  c.use_all({
              'OpenTelemetry::Instrumentation::PG' => { enabled: false }
            })

  # Configure propagators to extract trace context from incoming requests
  # This enables the Rails app to continue traces started by the client
  # Using our custom propagator that fixes the frozen string issue
  c.propagators = [
    CustomTraceContextPropagator.new,
    OpenTelemetry::Baggage::Propagation.text_map_propagator
  ]
end

# Also broadcast logs to TraceLogger in addition to existing logger
Rails.logger.extend(ActiveSupport::Logger.broadcast(TraceLogger.new($stdout)))

# Custom Rack environment getter that fixes the frozen string issue in Ruby 2.7
# See: https://github.com/open-telemetry/opentelemetry-ruby/issues/1463
#
# The issue occurs when string interpolation creates frozen strings, which then
# fail when mutating methods like upcase! or tr! are called on them.
class CustomRackEnvGetter
  # Maps header names to Rack env keys
  # @param carrier [Hash] The Rack environment hash
  # @param key [String] The header key (e.g., 'traceparent')
  # @return [String, nil] The value from the Rack environment
  def get(carrier, key)
    carrier[to_rack_key(key)] || carrier[key]
  end

  # Returns the Rack environment keys for the given header key
  # @param key [String] The header key
  # @return [Array<String>] Array of possible Rack env keys
  def keys(carrier, key)
    [to_rack_key(key), key].select { |k| carrier.key?(k) }
  end

  protected

  # Converts a header key to the Rack environment key format
  # Uses the unary + operator to create a mutable string copy,
  # which prevents FrozenError in Ruby 2.7 with frozen_string_literal: true
  #
  # @param key [String] Header key (e.g., 'traceparent')
  # @return [String] Rack env key (e.g., 'HTTP_TRACEPARENT')
  def to_rack_key(key)
    # The +'' prefix creates a mutable copy of the string to avoid FrozenError
    ret = +"HTTP_#{key}"
    ret.tr!('-', '_')
    ret.upcase!
    ret
  end
end

# Custom text map propagator that uses our custom RackEnvGetter
class CustomTraceContextPropagator
  def initialize
    @propagator = OpenTelemetry::Trace::Propagation::TraceContext::TextMapPropagator.new
    @getter = CustomRackEnvGetter.new
  end

  # Extract trace context from carrier using custom getter
  def extract(carrier, context: OpenTelemetry::Context.current, getter: @getter)
    @propagator.extract(carrier, context: context, getter: getter)
  end

  # Inject trace context into carrier (delegates to standard propagator)
  def inject(carrier, context: OpenTelemetry::Context.current, setter: OpenTelemetry::Context::Propagation.text_map_setter)
    @propagator.inject(carrier, context: context, setter: setter)
  end

  # Returns the fields that this propagator will inject
  def fields
    @propagator.fields
  end
end

# Override the OpenTelemetry::Common::Propagation module to use our custom getter
# This ensures Rack instrumentation uses our fixed version
module OpenTelemetry
  module Common
    module Propagation
      class << self
        def rack_env_getter
          @rack_env_getter ||= CustomRackEnvGetter.new
        end
      end
    end
  end
end
