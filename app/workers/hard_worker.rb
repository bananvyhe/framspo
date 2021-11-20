class HardWorker < ApplicationController
	wrap_parameters format: [:json, :xml]
	require 'mechanize'
	require 'json'
	require 'httparty'
	include Sidekiq::Worker
	# require 'openssl'
	# require 'uri'
	
	def perform
		@rowsd = Array.new
		# @s = 3
		def selection_scrapped(row)
			puts "cooking.."
			pic = row.css('img').attr('src').to_s
			link = row.css('a').attr('href').to_s
			head = row.css('.qualifier').inner_text.to_s
			date = row.css('.date').inner_text.to_s
			desc = row.css('h2').inner_text.to_s

			# @s = @s + 2
			# puts @s
			data = {
				:pic => pic,
				:link => link,
				:head => head,
				:date => date,
				:desc => desc				
			}
			@rowsd = [*@rowsd, data]

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
			puts @m 
				if @m == 1
					selection_scrapped(rowf)
				end
			end
		end
		headers = {
			"Content-Type" => "application/json"  
		}
		if Rails.env.production?
			puts "send to news contr.."
			HTTParty.post("https://farmspot.ru/news",headers: headers, body: @rowsd.to_json)
		end
		if Rails.env.development?
			puts "send to news contr.."
			HTTParty.post("http://localhost:3000/news",headers: headers, body: @rowsd.to_json)
		end		


		# puts @rowsd
	end

end
