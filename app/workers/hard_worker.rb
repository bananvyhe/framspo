class HardWorker < ApplicationController
	include Sidekiq::Worker
	wrap_parameters format: [:json, :xml]
	require 'mechanize'
	require 'json'
	require 'httparty'
	# require 'openssl'
	# require 'uri'
	
	def perform
		@rowsd = Array.new
		@tokenrapid = "bearer " + %x{yc iam create-token}
		@s = 3
		def selection_scrapped(row)
			pic = row.css('img').attr('src').to_s
			link = row.css('a').attr('href').to_s
			head = row.css('.qualifier').inner_text.to_s
			date = row.css('.date').inner_text.to_s
			desc = row.css('h2').inner_text.to_s

			@s = @s + 2
			puts @s
			data = {
				:pic => pic,
				:link => link,
				:head => head,
				:date => date,
				:desc => desc				
			}
			@rowsd = [*@rowsd, data]

			# def transclucate |in|
			# 	@headersb = {
	  #       "Content-Type" => "application/json",
	  #       "Authorization" => @tokenrapid 
	  #     }
	  #     bodyb = {
	  #       "folderId"=>"b1g86cba4bfmnhhsnobp",
	  #       "texts"=> in,
	  #       "targetLanguageCode"=>"ru"
	  #     }
	  #     resp = HTTParty.post("https://translate.api.cloud.yandex.net/translate/v2/translate", headers: @headersb, body: bodyb.to_json)
	  #     render = JSON.parse resp.to_s 
	  #     out = render["translations"]
	  #     tex = out[0]
	  #     headfin = tex.slice("text")['text']
	  #     puts headfin
			# end
		end
 		agent = Mechanize.new
 		url='https://www.pocketgamer.biz/asia/news/'
 		page = agent.get(url)
		@rowsd = Array.new
		page.css('.module.latest.news').each do |row|
			@m = 0
			rowcss = row.css('.item')
			rowcss.each do |rowf|
			@m = @m + 1
			# puts @m
				if @m != 5
					selection_scrapped(rowf)
				end
			end
		end
		puts @rowsd
	end

end
