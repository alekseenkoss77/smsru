require "smsru/version"

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
      @mail = 'admin@example.com'
      @phone = '793492394'
      @api_id = ''
    end
  end
end
end
