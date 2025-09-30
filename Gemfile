# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.7.7'

gem 'dotenv-rails', '2.7.2', require: 'dotenv/rails-now' # Keep this gem at the top to avoid load order issues
gem 'rails', '6.0.6.1'
gem 'activemodel-serializers-xml', '1.0.2'
gem 'devise', '4.8.1'
gem 'actioncable', '6.0.6.1'
gem 'actionmailbox', '6.0.6.1'
gem 'actionmailer', '6.0.6.1'
gem 'actionpack', '6.0.6.1'
gem 'actiontext', '6.0.6.1'
gem 'actionview', '6.0.6.1'
gem 'active_attr', '0.15.4'
gem 'activejob', '6.0.6.1'
gem 'activemodel', '>= 3.0.0'
gem 'activerecord', '6.0.6.1'
gem 'activestorage', '6.0.6.1'
gem 'activesupport'
# gem 'active_zuora', '2.5.4', git: 'git@github.com:HireologyCorp/active_zuora.git'
gem 'addressable', '~> 2.8.0' # replacement for the standard URI lib which more closely adheres to current standards
# gem 'adp-connection', git: 'git@github.com:HireologyCorp/adp-connection-ruby.git', ref: '1ccd79b'
gem 'agnostic', '~> 0.1.1'
gem 'ancestry', '~> 3.0.7'
gem 'attrio'
gem 'awesome_print', '1.6.1' # nicely formats whatever it's passed, helpful debugging tool
gem 'aws-sdk-s3', '1.48.0'
gem 'bcrypt'
gem 'bootstrap', '4.6.0'
gem 'bunny', '2.9.2'
gem 'chronic'
gem 'command_line_reporter', '~> 3.3'
gem 'composite_primary_keys', '12.0.10' # keep until rails 6.1
gem 'config', '2.2.1'
gem 'decent_exposure', '3.0.2'
gem 'display_case'
gem 'doorkeeper', '~> 5.4' # used for managing the mobile auth api
gem 'draper', '3.1.0'
# gem 'erlen', '0.2.0', git: 'git@github.com:HireologyCorp/erlen.git'
gem 'erubis', '2.7.0'
gem 'flipper', '0.25.3'
gem 'flipper-redis', '~> 0.25.3'
gem 'flipper-ui', '0.25.3'
gem 'geocoder', '1.6.4'
gem 'google-api-client', '~> 0.52.0'
gem 'google-protobuf', '~> 3.25.5'
gem 'googleauth', '~> 0.11.0'
gem 'griddler', '1.5.2' # Email capture
gem 'griddler-sendgrid', '~> 0.0.1'
gem 'hstore_accessor', '1.1.0'
gem 'httparty', '~> 0.18.1'
gem 'icalendar'
gem 'jquery-migrate-rails'
gem 'jquery-rails'
gem 'rails-ujs', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'json', '2.5.1'
gem 'jsonapi-resources', '0.9.0'
gem 'jwt', '~> 2.7.0'
gem 'railties', '>= 3.0'
# TODO: This is a temporary solution while kt-paperclip determines what to do and/or we migrate to ActiveStorage
# gem 'kt-paperclip', git: 'git@github.com:HireologyCorp/kt-paperclip.git', branch: 'use-marcel'
gem 'launchdarkly_api', '~> 13.0'
gem 'launchdarkly-server-sdk', '7.3.2'
gem 'light-service', '~> 0.6.0'
gem 'modernizr-rails'
gem 'money-rails'
gem 'net-http', '~> 0.3.2'
gem 'nokogiri', '~> 1.13.9'
gem 'oauth'
gem 'pg', '1.2.3'
gem 'pg_search', '2.3.2'
gem 'phone', '~> 1.2'
gem 'prometheus_exporter', '~> 0.5.3'
gem 'public_suffix', '~> 4.0.3'
gem 'rack-attack', '~> 6.6.1'
gem 'rake', '~> 13.0.1'
gem 'react-rails', '2.5.0'
gem 'redis-rails'
gem 'remotipart', '~> 1.2'
gem 'responders', '>= 3.0.1'
gem 'resque', '~> 2.6.0'
gem 'resque-job-stats', '0.5.0'
gem 'resque-retry', '1.8.1'
gem 'resque-scheduler', '~> 4.10.0'
gem 'resque-sentry', '1.2.0' # allows sentry/raven to handle exceptions that happen in our resque workers
gem 'rest-client'
gem 'restforce', '~> 5.0.4'
gem 'roadie', '3.2.2'
gem 'roadie-rails', '2.1.0'
gem 'rubyzip', '~> 2.2.0'
gem 'sass-rails', '5.1.0'
gem 'savon', '1.2.0'
gem 'select2-rails', '4.0.13'
gem 'sentry-raven', '3.1.1' # error and exception management, see sentry.io
gem 'sinatra', '2.2.3'
gem 'sprockets-rails', '3.2.2' # used by the rails assets pipeline
gem 'traceroute', '~> 0.8.1' # used to view unused routes
gem 'twitter-typeahead-rails', '0.10.5' # WARNING: bumping this any higher breaks the search results styles, see hotfix-20190724-141130 for info
gem 'typhoeus'
gem 'uglifier', '2.7.2' # for minifying our js assets
gem 'underscore-rails'
gem 'uuid'
gem 'uuidtools'
gem 'vault', '~> 0.7.3'
gem 'wicked_pdf', '~> 1.1.0'
gem 'will_paginate', '3.1.7'
gem 'will_paginate-bootstrap', '~> 1.0.1'
# coverband needs to be below resque
# DataDog observability
gem 'ddtrace', require: false
gem 'dogstatsd-ruby', '~> 5.3'
group :development, :test do
  gem 'flog', require: false
  gem 'json_spec', '1.1.5'
  gem 'launchy'
  gem 'minitest'
  # gem 'phantomjs', '2.1.1'
  # gem 'pronto', '0.10.0'
  # gem 'pronto-brakeman', '0.10.0', require: false
  # gem 'pronto-eslint_npm', '0.10.0', require: false
  # gem 'pronto-rubocop', '0.10.0', require: false
  gem 'pry', '0.12.2' # alternative repl to irb, provides a number of useful console features: https://github.com/pry/pry
  gem 'pry-byebug' # pry plugin that provides some convenient ways to step through program execution and the call stack, https://github.com/deivid-rodriguez/pry-byebug
  gem 'rails-controller-testing', '1.0.5'
  gem 'rdoc', '~> 6.3.1'
  gem 'rspec', '3.10.0'
  gem 'rspec-core', '3.10.1'
  gem 'rspec-rails', '4.0.2'
  gem 'rubocop', '0.93.1', require: false
  # gem 'rugged', '0.28.4.1' # used by pronto, 0.27.x address occasional segfaults we'd get when using 0.26.x on ruby 2.5.x
  gem 'sass', '~> 3.5.2'
  gem 'simplecov', '~> 0.13.0'
  gem 'timecop', '~> 0.8'
  gem 'watir', '~> 6.8.4'
end
group :development do
  gem 'better_errors', '2.9.1'
  gem 'binding_of_caller', '0.8.0'
  gem 'bootsnap', '1.5.1', require: false
  gem 'bullet', '6.1.3'
  gem 'debug', '1.11.0'
  gem 'guard', '2.16.2'
  # gem 'guard-livereload', '2.5.2', require: false
  gem 'guard-rails', '0.7.2'
  gem 'puma', '5.6.9'
  gem 'rack-mini-profiler', '2.3.0', require: false
end
# group :test do
#   gem 'capybara', '~> 3.34.0'
#   gem 'capybara-screenshot', '~> 1.0', '>= 1.0.22'
#   gem 'capybara-selenium', '~> 0.0.6'
#   gem 'codeclimate-test-reporter', '1.0.9', require: false
#   gem 'connection_pool'
#   gem 'email_spec', '~> 2.1'
#   gem 'factory_bot_rails', '~> 6.1', require: false
#   gem 'fakeredis', '0.6.0', require: false # temporary gem version lock
#   gem 'reverse_coverage'
#   gem 'shoulda-callback-matchers', '~> 1.1.4'
#   gem 'shoulda-matchers', '~> 3.1.3'
#   gem 'site_prism', '~> 3.2'
#   gem 'vcr', '6.1.0'
#   gem 'webdrivers', '~> 4.2.0', require: false # manages chromedriver interactions, mostly for selenium-webdriver
#   gem 'webmock', '~> 3.5'
# end
gem 'amazing_print', '~> 1.4'
gem 'rails_semantic_logger', '~> 4.10'
gem 'rack-cors', '~> 2.0'
gem 'oauth2', '~> 2.0'
gem 'ar_after_transaction', '~> 0.8.0'
gem 'foreman', '~> 0.87.2'

# New OpenTelemetry gems
gem 'opentelemetry-sdk', '~> 1.2', '>= 1.2.1'
gem 'opentelemetry-instrumentation-all', '~> 0.33.0'
gem 'opentelemetry-exporter-otlp', '~> 0.24.0'

