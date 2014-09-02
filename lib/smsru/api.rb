# coding: utf-8
require 'net/http'

module Smsru
  # API is class which can send sms message cross www.sms.ru service
  class API

    DEFAULT_GROUP_SIZE = 100

    class << self

      def balance(api_id=Smsru.configuration.api_id)
        balance = Net::HTTP.get(URI.parse(URI.escape("http://sms.ru/my/balance?" + "api_id=#{api_id}"))).split("\n")
        if balance[0] == '100'
          result = balance[1]
        else
          result = nil
        end
        result
      end

      def send_sms(to, text, api_id=Smsru.configuration.api_id, from=Smsru.configuration.from, test=false)
        Net::HTTP.get(URI.parse(URI.escape(Smsru.configuration.sms_url + "api_id=#{api_id}&from=#{from.to_s}&to=#{to}&text=#{text.to_s}#{'&test=1' if test}")))
      end

      # групповая отправка смс, по 100 номеров
      def group_send(to, text, api_id=Smsru.configuration.api_id, from=Smsru.configuration.from, test=false)
        to = to.each_slice(DEFAULT_GROUP_SIZE).to_a
        to.each do |sub_array|
          numbers = sub_array.join(',')
          send_sms(numbers, text, api_id, from, test)           
        end
      end
    
    end
  end
end
