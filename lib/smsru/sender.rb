require 'net/http'

module Smsru
	class Sender
		class << self
			def single_sms(to,text,api_id=Smsru.configuration.api_id,from=Smsru.configuration.from)
				Net::HTTP.get(URI.parse(URI.escape(Smsru.configuration.url + "api_id=#{api_id}&from=#{from.to_s}&to=#{to.to_i}&text=#{text.to_s}")))
			end
		end
	end
end
