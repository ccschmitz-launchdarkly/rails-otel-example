class OtelDemoJob < ApplicationJob
  queue_as :default

  def perform
    tracer = OpenTelemetry.tracer_provider.tracer('rails-otel-example.otel_demo', '1.0')
    tracer.in_span('otel_demo.job.perform', attributes: { 'job' => 'OtelDemoJob' }) do
      Rails.logger.info('OTEL DEMO JOB: started')
      sleep 0.05

      # Test HTTP request in background job context
      tracer.in_span('otel_demo.job.http_request') do
        begin
          require 'net/http'
          response = Net::HTTP.get(URI('https://httpbin.org/get'))
          Rails.logger.info("OTEL DEMO JOB: HTTP request successful, response length: #{response.length}")
        rescue => e
          Rails.logger.error("OTEL DEMO JOB: HTTP request failed: #{e.class}: #{e.message}")
          Rails.logger.error(e.backtrace.join("\n"))
        end
      end

      tracer.in_span('otel_demo.job.child') do
        sleep 0.02
      end
      Rails.logger.info('OTEL DEMO JOB: finished')
    end
  end
end


