# coding: utf-8
#
# Sender is class which can send sms message cross www.sms.ru service
# 
# class methods:
# sample:
# => Smsru::Sender.single_sms('79457375', 'foo bar')
# this is work with standart parametrs.
# You can also override other arguments in your code:
# => api_id
# => from

  
require 'net/http'

module Smsru
	class Sender

    DEFAULT_GROUP_SIZE = 100

		class << self

      def sms_send(to,text,api_id=Smsru.configuration.api_id,from=Smsru.configuration.from)
        Net::HTTP.get(URI.parse(URI.escape(Smsru.configuration.sms_url + "api_id=#{api_id}&from=#{from.to_s}&to=#{to}&text=#{text.to_s}")))
      end

      def test_send(to,text,api_id=Smsru.configuration.api_id,from=Smsru.configuration.from)
        Net::HTTP.get(URI.parse(URI.escape(Smsru.configuration.sms_url + "api_id=#{api_id}&from=#{from.to_s}&to=#{to}&text=#{text.to_s}&test=1")))
      end
			# for one of message
      def single_sms(to,text,api_id=Smsru.configuration.api_id,from=Smsru.configuration.from)
				sms_send()
			end

      # групповая отправка смс, по 100 номеров
      def group_send(to,text,api_id=Smsru.configuration.api_id,from=Smsru.configuration.from)
        to.to_a if !to.is_a? Array
        max = to.size
        i = 0
        while(i < max) do
          # вычисляем последний индекс 
          lim = ((i+100)-1)     
          # 100 номеров для отправки 
          numbers = to[i..l].join(',')    
          # групповая отсылка
          test_send(numbers,text,api_id=Smsru.configuration.api_id,from=Smsru.configuration.from)
          i += 100              
        end
      end
		end
	end
end
