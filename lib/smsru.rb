require 'smsru/version'

module Smsru
  require 'smsru/configuration'
  require 'smsru/status'
  require 'smsru/api'
  require 'smsru/response'
  require 'smsru/helpers'

  include Status
  
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  require 'smsru/railties/config' if defined?(Rails)
end
