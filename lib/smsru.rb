require File.expand_path('../smsru/status', __FILE__)
require File.expand_path('../smsru/sender', __FILE__)

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
    attr_accessor :mail, :api_id, :phone

    def initialize
      self.mail = 'alekseenkoss@gmail.com'
      self.phone = '79539136846'
      self.sms_url = "http://sms.ru/sms/send?"
      self.api_id = 'e7f6a922-838e-d954-99f9-3e44d4c63ebd'
    end
  end
end
