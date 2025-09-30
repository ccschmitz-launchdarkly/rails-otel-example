#!/usr/bin/env ruby

# Load Rails environment to get OpenTelemetry instrumentation
require_relative 'config/environment'

puts "Testing HTTP clients with OpenTelemetry instrumentation..."

# Test Net::HTTP
puts "\n=== Testing Net::HTTP ==="
begin
  require 'net/http'
  require 'uri'

  tracer = OpenTelemetry.tracer_provider.tracer('test', '1.0')
  tracer.in_span('test.net_http') do
    response = Net::HTTP.get(URI('https://httpbin.org/get'))
    puts "Net::HTTP success: #{response.length} bytes"
  end
rescue => e
  puts "Net::HTTP error: #{e.class}: #{e.message}"
  puts e.backtrace.join("\n")
end

# Test HTTParty
puts "\n=== Testing HTTParty ==="
begin
  require 'httparty'

  tracer = OpenTelemetry.tracer_provider.tracer('test', '1.0')
  tracer.in_span('test.httparty') do
    response = HTTParty.get('https://httpbin.org/get')
    puts "HTTParty success: #{response.body.length} bytes"
  end
rescue => e
  puts "HTTParty error: #{e.class}: #{e.message}"
  puts e.backtrace.join("\n")
end

# Test RestClient
puts "\n=== Testing RestClient ==="
begin
  require 'rest-client'

  tracer = OpenTelemetry.tracer_provider.tracer('test', '1.0')
  tracer.in_span('test.restclient') do
    response = RestClient.get('https://httpbin.org/get')
    puts "RestClient success: #{response.body.length} bytes"
  end
rescue => e
  puts "RestClient error: #{e.class}: #{e.message}"
  puts e.backtrace.join("\n")
end

# Test Typhoeus
puts "\n=== Testing Typhoeus ==="
begin
  require 'typhoeus'

  tracer = OpenTelemetry.tracer_provider.tracer('test', '1.0')
  tracer.in_span('test.typhoeus') do
    response = Typhoeus.get('https://httpbin.org/get')
    puts "Typhoeus success: #{response.body.length} bytes"
  end
rescue => e
  puts "Typhoeus error: #{e.class}: #{e.message}"
  puts e.backtrace.join("\n")
end

# Test detailed Net::HTTP (more likely to trigger the error)
puts "\n=== Testing detailed Net::HTTP ==="
begin
  require 'net/http'
  require 'uri'

  tracer = OpenTelemetry.tracer_provider.tracer('test', '1.0')
  tracer.in_span('test.net_http_detailed') do
    uri = URI('https://httpbin.org/get')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    puts "Detailed Net::HTTP success: #{response.body.length} bytes, code: #{response.code}"
  end
rescue => e
  puts "Detailed Net::HTTP error: #{e.class}: #{e.message}"
  puts e.backtrace.join("\n")
end

puts "\nTest completed."

