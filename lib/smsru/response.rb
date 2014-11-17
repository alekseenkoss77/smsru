module Smsru
  class Response

    attr_accessor :phone, :raw, :code, :balance, :status, :message

    def initialize(phone, response)
      @phone = phone
      unless response.nil?
        @raw = response
        array = response.split("\n")
        @status = array.first
        @code = array.select { |c| c[/^\d+\-\d+$/] }
        @balance = array.last.split('=')[1] unless array.last.nil?
        @message = Status::SMS_STATUS[@status]
      end
    end

    def success?
      status == '100'
    end

    def fail?
      !(success?)
    end

    def == response
      (Response === response) ? self.to_h == response.to_h : false
    end

    def to_h
      {code: code, phone: phone, raw: raw, status: status, message: message, balance: balance}
    end

  end
end