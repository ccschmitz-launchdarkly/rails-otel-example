class TestHttpInMigration < ActiveRecord::Migration[6.0]
  def change
    # Add a simple table to make this a real migration
    create_table :http_test_logs do |t|
      t.string :status
      t.text :response_data
      t.timestamps
    end

    # Test HTTP request during migration - this is where the error might occur
    puts "Making HTTP request during migration..."
    begin
      require 'net/http'
      require 'uri'

      response = Net::HTTP.get(URI('https://httpbin.org/get'))
      puts "HTTP request successful during migration, response length: #{response.length}"

      # Also test other HTTP clients
      require 'httparty'
      httparty_response = HTTParty.get('https://httpbin.org/get')
      puts "HTTParty request successful during migration"

      require 'rest-client'
      restclient_response = RestClient.get('https://httpbin.org/get')
      puts "RestClient request successful during migration"

    rescue => e
      puts "HTTP request failed during migration: #{e.class}: #{e.message}"
      puts e.backtrace.join("\n")
    end
  end
end
