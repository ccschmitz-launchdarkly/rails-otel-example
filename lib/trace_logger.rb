require "logger"
require "opentelemetry-api"

class TraceLogger < ::Logger
  def initialize(logdev, level: ::Logger::DEBUG, **kwargs)
    super(logdev, level: level, **kwargs)
    @tracer = OpenTelemetry.tracer_provider.tracer("log_tracer", "0.1.0")
  end

  # Intercepts ALL logs
  def add(severity, message = nil, progname = nil, &block)
    msg = (message || (block && block.call) || progname).to_s
    sev = format_severity(severity)

    current = OpenTelemetry::Trace.current_span
    if current.context.valid?
      current.add_event("log", attributes: log_attrs(sev, msg, progname))
    else
      @tracer.in_span("log") do |span|
        span.add_event("log", attributes: log_attrs(sev, msg, progname))
      end
    end

    super(severity, message, progname, &block) # keep normal logging behavior
  end

  private

  def log_attrs(severity, message, progname)
    {
      "log.severity" => severity,
      "log.message"  => message,
      "log.logger"   => "rails",
      "log.progname" => (progname || "").to_s
    }.compact
  end

  def current_tags
    tags = Thread.current[:activesupport_tagged_logging_tags]
    Array(tags).join(", ") if tags && !tags.empty?
  end
end
