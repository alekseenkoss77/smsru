module Smsru
  class Configuration
    attr_accessor :mail, 
                  :api_id, 
                  :phone, 
                  :sms_url, 
                  :from, 
                  :test, 
                  :format

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