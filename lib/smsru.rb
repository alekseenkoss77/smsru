require File.expand_path('../smsru/status', __FILE__)
require File.expand_path('../smsru/api', __FILE__)
require File.expand_path('../smsru/response', __FILE__)

module Smsru
  include Status
  
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :mail, :api_id, :phone, :sms_url, :from, :test, :format

    def initialize
      self.from = ''
      self.mail = ''
      self.phone = ''
      self.sms_url = "http://sms.ru/sms/send?"
      self.api_id = ''
      self.test = false
      self.format = false
    end
  end
end
