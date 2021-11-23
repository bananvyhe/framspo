class News < ApplicationRecord
	require 'net/http'
	require 'uri'

	def self.tokenmake
		uri = URI.parse("https://iam.api.cloud.yandex.net/iam/v1/tokens")
		request = Net::HTTP::Post.new(uri)

		request.body = JSON.dump({
		  "yandexPassportOauthToken" => Rails.application.credentials.yaOauth
		})
		req_options = {
			use_ssl: uri.scheme == "https",
		}
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			 @tokwars =  http.request(request).body
		end
		# response.code
		# response.body
		formj = JSON.parse(@tokwars)
		tokenrapid = "bearer " + formj['iamToken']
	end	

	 @n = 0
	 
    def  self.tranklukate(ina, tokenrapid)
      # puts tokenrapid
      @n = @n + 1
      puts @n.to_s + "tranklucating.."
        @headersb = {
          "Content-Type" => "application/json",
          "Authorization" => tokenrapid
        }

        bodyb = {
          "folderId"=>"b1g86cba4bfmnhhsnobp",
          "texts"=> ina,
          "targetLanguageCode"=>"ru"
        }
         
        resp = HTTParty.post("https://translate.api.cloud.yandex.net/translate/v2/translate", headers: @headersb, body: bodyb.to_json)
        render = JSON.parse resp.to_s 
        out = render["translations"]
        tex = out[0]
        headfin = tex.slice("text")['text']
    end


end
