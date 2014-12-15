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

      def send_sms( phone, text, options={})
        api_id = options[:api_id] || Smsru.configuration.api_id
        from   = options[:from]   || Smsru.configuration.from
        test   = options[:test]   || Smsru.configuration.test

        url = Smsru.configuration.sms_url
        url += "api_id=#{api_id}"
        url += "&from=#{from}" if from.present?
        url += "&to=#{phone}"
        url += "&text=#{text}"
        url += "&test=1" if test

        raw_response = Net::HTTP.get(URI.parse(URI.escape(url)))
        handler_response phone, raw_response
      end

      # групповая отправка смс, по 100 номеров
      def group_send(to, text, options={})
        to = to.each_slice(DEFAULT_GROUP_SIZE).to_a
        to.map do |sub_array|
          numbers = sub_array.join(',')
          send_sms(numbers, text, options)
        end
      end

      private

      def handler_response phone, raw_response
        if Smsru.configuration.format
          Smsru::Response.new( phone, raw_response )
        else
          raw_response
        end
      end

    end
  end
end
