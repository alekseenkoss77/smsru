# require "smsru/version"
require File.expand_path('../smsru/status', __FILE__)

module Smsru
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :mail, :api_id, :phone

    def initialize
      @mail = 'alekseenkoss@gmail.com'
      @phone = '79539136846'
      @api_id = 'e7f6a922-838e-d954-99f9-3e44d4c63ebd'
    end
  end
end
