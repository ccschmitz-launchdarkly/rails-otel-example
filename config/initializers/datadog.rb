require 'ddtrace'

Datadog.configure do |c|
  c.tracing.instrument :rails, service_name: 'staging-rails-app'
  c.tracing.instrument :rake
end
