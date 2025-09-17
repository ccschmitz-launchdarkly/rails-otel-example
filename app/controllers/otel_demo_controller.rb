require 'net/http'
require 'uri'

class OtelDemoController < ApplicationController
  def index
  end

  def log
    Rails.logger.info('OTEL DEMO: info log from /otel/log')
    Rails.logger.warn('OTEL DEMO: warn log from /otel/log')
    Rails.logger.error('OTEL DEMO: error log from /otel/log')
    message = 'Logs emitted.'
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to action: :index
      end
      format.js do
        flash.now[:notice] = message
        render :update
      end
    end
  end

  def trace
    tracer = OpenTelemetry.tracer_provider.tracer('rails-otel-example.otel_demo', '1.0')
    tracer.in_span('otel_demo.custom_trace', attributes: { 'demo.feature' => 'trace' }) do |span|
      span.add_event('demo-start')
      span.set_attribute('demo.attribute', 'value')
      perform_child_span(tracer)
      sleep 0.05
      span.add_event('demo-end')
    end
    message = 'Custom trace created.'
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to action: :index
      end
      format.js do
        flash.now[:notice] = message
        render :update
      end
    end
  end

  def http
    tracer = OpenTelemetry.tracer_provider.tracer('rails-otel-example.otel_demo', '1.0')
    tracer.in_span('otel_demo.http') do |_span|
      Net::HTTP.get(URI('https://example.com'))
    end
    message = 'External HTTP request made.'
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to action: :index
      end
      format.js do
        flash.now[:notice] = message
        render :update
      end
    end
  end

  def handled_error
    tracer = OpenTelemetry.tracer_provider.tracer('rails-otel-example.otel_demo', '1.0')
    tracer.in_span('otel_demo.handled_error') do |span|
      begin
        raise StandardError, 'This is a handled demo error'
      rescue => e
        Rails.logger.error("Handled error: #{e.class}: #{e.message}")
        span.record_exception(e) if span.respond_to?(:record_exception)
        span.add_event('exception', attributes: { 'exception.type' => e.class.name, 'exception.message' => e.message })
        if span.respond_to?(:status=) && defined?(OpenTelemetry::Trace::Status) && OpenTelemetry::Trace::Status.respond_to?(:error)
          span.status = OpenTelemetry::Trace::Status.error('handled error')
        end
      end
    end
    message = 'Handled error recorded.'
    respond_to do |format|
      format.html do
        flash[:alert] = message
        redirect_to action: :index
      end
      format.js do
        flash.now[:alert] = message
        render :update
      end
    end
  end

  def unhandled_error
    raise 'Intentional unhandled error from OTEL demo'
  end

  def background_job
    OtelDemoJob.perform_later
    message = 'Background job enqueued.'
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to action: :index
      end
      format.js do
        flash.now[:notice] = message
        render :update
      end
    end
  end

  private

  def perform_child_span(tracer)
    tracer.in_span('otel_demo.child_span') do |_child|
      sleep 0.02
    end
  end
end


