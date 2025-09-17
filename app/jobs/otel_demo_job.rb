class OtelDemoJob < ApplicationJob
  queue_as :default

  def perform
    tracer = OpenTelemetry.tracer_provider.tracer('rails-otel-example.otel_demo', '1.0')
    tracer.in_span('otel_demo.job.perform', attributes: { 'job' => 'OtelDemoJob' }) do
      Rails.logger.info('OTEL DEMO JOB: started')
      sleep 0.05
      tracer.in_span('otel_demo.job.child') do
        sleep 0.02
      end
      Rails.logger.info('OTEL DEMO JOB: finished')
    end
  end
end


