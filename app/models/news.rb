class News < ApplicationRecord
	require 'net/http'
	require 'uri'
	
	# curl -d "{\"yandexPassportOauthToken\":\"Rails.application.credentials.yaOauth\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens"

	def self.tokenmake
		result = %x{yc iam create-token}
		puts "tokenmake tokenmake tokenmake tokenmake"
		puts "Tokenmake output: #{result}"
		# uri = URI.parse("https://iam.api.cloud.yandex.net/iam/v1/tokens")
		# request = Net::HTTP::Post.new(uri)

		# request.body = JSON.dump({
		#   "yandexPassportOauthToken" => Rails.application.credentials.yaOauth
		# })
		# req_options = {
		# 	use_ssl: uri.scheme == "https",
		# }
		# response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		# 	 @tokwars =  http.request(request).body
		# end
		# formj = JSON.parse(@tokwars)

		# tokenrapid = "bearer " + formj['iamToken']
	end	

	def self.piu(d, tok)
    @headersb = {
      "Content-Type" => "application/json",
      "Authorization" => tok
    }

    bodyb = {
      "folderId"=>"b1g86cba4bfmnhhsnobp",
      "texts"=> d,
      "targetLanguageCode"=>"ru",
      "format" => "HTML"
    }
     
    resp = HTTParty.post("https://translate.api.cloud.yandex.net/translate/v2/translate", headers: @headersb, body: bodyb.to_json)
    render = JSON.parse resp.to_s 
    out = render["translations"]
    # puts out
    tex = out[0]
    headfin = tex.slice("text")['text']  		
	end

  def  self.tranklukate(ina, tokenrapid)
  	# puts @n.to_s + "---++++size++++-----"
  	if ina.size > 9900
  		@ina = ina
  		puts ina.size
  		puts "it's big"
  		#вычисляем весь размер строки
  		@strlengt = ina.size
  		#макс кол-во символов
  		@segment = 8900
  		#создаем пустой массив для отрезков
  		@allparts = Array.new
  		@newsegment = 0

			#первый отрезанный кусок
			part = ina[0,@segment]
  		#в массив его
  		@allparts = [*@allparts, part]  

  		@allpartsize = @allparts[0].to_s.size
  		@newsegment += @segment		
 			# puts @allpartsize

  		def self.butcherezka(beg, stp)
  			puts "butcherrerz"
 
  			part = @ina[beg,stp]
  			@allparts = [*@allparts, part] 
  			@newsegment += @segment
  			puts @newsegment
  		end

  		unless @allpartsize > ina.size-10 
  			puts "to buch"
  			butcherezka(@allpartsize, @newsegment)
  		end

  		puts "+++++++++++++++++++++++"

  		@sumstr = @allparts[0].to_s.size + @allparts[1].to_s.size
  		puts @sumstr
  		puts @allparts.to_s.size
  		puts "+++++++++++++++++++++++"

			transpart = nil
			@alltrans = Array.new

			@allparts.each do |d|
				result = piu(d, tokenrapid)
				@alltrans = [*@alltrans, result]
			end
			@sumtranstr = nil
			@alltrans.each do |d|
				# puts d.class
				 @sumtranstr =  @sumtranstr.to_s + d
				# pus = d[0].to_s
				
				# @sumtranstr = @sumtranstr.to_s + pus.to_s
			end
			puts "|||||||||||||||||||"
			@fin = @sumtranstr
		elsif
			 @fin = piu(ina, tokenrapid)

  	end
  	hj = @fin
  end

end
