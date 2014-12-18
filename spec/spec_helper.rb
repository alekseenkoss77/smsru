require "bundler"
Bundler.setup

require 'rails/all'
require 'rspec/rails'

require "smsru"
require "./lib/smsru"
require 'rspec'
require 'webmock/rspec'
require 'vcr'

Bundler.require(:test)


VCR.configure do |c|
  c.cassette_library_dir     = 'spec/fixtures/cassette_library'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :none }
end

ENV["RAILS_ENV"] ||= 'test'

require "dummy/config/environment"