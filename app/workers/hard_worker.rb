class HardWorker < ApplicationController
	include Sidekiq::Worker
	wrap_parameters format: [:json, :xml]
	require 'mechanize'
	require 'json'
	require 'httparty'
	# require 'openssl'
	# require 'uri'
	def perform
		def selection_scrapped(row)
			pic = row.css('img').attr('src').to_s
			link = row.css('a').attr('href').to_s
			head = row.css('.qualifier').inner_text.to_s
			date = row.css('.date').inner_text.to_s
			desc = row.css('h2').inner_text.to_s

			tokenrapid = "bearer " + %x{yc iam create-token}
			@headersb = {
        "Content-Type" => "application/json",
        "Authorization" => tokenrapid 
      }
      bodyb = {
        "folderId"=>"b1g86cba4bfmnhhsnobp",
        "texts"=> head,
        "targetLanguageCode"=>"ru"
      }
      resp = HTTParty.post("https://translate.api.cloud.yandex.net/translate/v2/translate", headers: @headersb, body: bodyb.to_json)
      render = JSON.parse resp.to_s 
      puts render


			# rowd = row.css('.item item-list').inner_text
			# puts '5'
			# puts rowd
			# title  = row.css
			# print title.force_encoding('UTF-8')
			# File.write('667.html', title.body)
		end

		# puts signin_page.css('.module.latest.news').inner_text
 		agent = Mechanize.new
 		url='https://www.pocketgamer.biz/asia/news/'
 		page = agent.get(url)
 		# show_more = agent.page
 		# print show_more.body.force_encoding('UTF-8')
		# File.write('666.html', show_more.body)
		@rowsd = Array.new
		# @n = 0
		# puts = page_more.link_with(text: 'More').click
		# puts page.css('.module.latest.news').inner_text

		page.css('.module.latest.news').each do |row|
			# puts row.css('.item.item-large').attr('href').to_s

			# @n = @n + 1 
			# puts @n
			# if @n == 7
				@m = 0
				rowcss = row.css('.item')
				rowcss.each do |rowf|
				@m = @m + 1
				puts @m
				if @m != 5
					selection_scrapped(rowf)
					# puts rowf.css('img').attr('src').to_s
					# puts rowf.css('a').attr('href').to_s
					# puts rowf.css('.qualifier').inner_text.to_s
					# puts rowf.css('.date').inner_text.to_s
					# puts rowf.css('h2').inner_text.to_s
				end
 				# selection_scrapped(rowf)
 				# puts "ds"
 				end
			# end
 			# 	rowd = row.css('.container').inner_text 
 			# 	puts rowd
			# @rowsd = [*@rowsd, rowd]
		end
		# File.write('668.html', @rowsd)
	end
 
end
