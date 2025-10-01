require "logger"
require "active_support/logger"
require "opentelemetry-api"

class TraceLogger < ::Logger
  def initialize(logdev, level: ::Logger::DEBUG, **kwargs)
    super(logdev, level: level, **kwargs)
    @tracer = OpenTelemetry.tracer_provider.tracer("log_tracer", "0.1.0")
  end

  def add(severity, message = nil, progname = nil, &block)
    msg = (message || (block && block.call) || progname).to_s
    sev = format_severity(severity)

    # Leverages a mechanism for creating logs from a trace on the LD backend.
    # Currently only processes a single event per span.
    # Could investigate state of logs SDK in Ruby and backward compatibility.
    @tracer.in_span("log") do |span|
      span.add_event("log", attributes: log_attrs(sev, msg, progname))
    end

    begin
      super(severity, message, progname, &block) # keep normal logging behavior
    rescue Errno::EPIPE
      # Ignore broken pipe errors - happens when STDOUT is closed/disconnected
      # The logging will continue to other appenders
    end
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
