class HardWorker < ApplicationController
	wrap_parameters format: [:json, :xml]
	require 'mechanize'
	require 'json'
	require 'httparty'
	include Sidekiq::Worker
	# require 'openssl'
	# require 'uri'
	
	def perform
		def to_news_trank(data)
			headers = {
				"Content-Type" => "application/json"  
			}
			if Rails.env.production?
				puts "send to news contr.."
				HTTParty.post("https://farmspot.ru/news",headers: headers, body: data.to_json)
			end
			if Rails.env.development?
				puts "send to news contr.."
				HTTParty.post("http://localhost:3000/news",headers: headers, body: data.to_json)
			end					
		end

		@rowsd = Array.new
		# @s = 3
		def selection_scrapped(row)
			puts "cooking.."
			pic = row.css('img').attr('src').to_s
			link = row.css('a').attr('href').to_s
			link = 'https://www.pocketgamer.biz'+link
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

		@datatwo = Array.new
		def selection_scrapped_two(row)
			puts "cooking2.."
			head = row.css('h2').inner_text.to_s
			desc = row.css('.post-summary').inner_text.to_s
			desc = desc[1..-10]
			pic = row.css('.img-holder').attr('data-src').to_s
			link = row.css('.title a').attr('href').to_s
			data = {
				:pic => pic,
				:link => link,
				:head => head,
				:date => DateTime.now.strftime('%m/%d/%Y'),
				:desc => desc				
			}
			@datatwo = [*@datatwo, data]
		end

 		agent = Mechanize.new
 		url=['https://www.pocketgamer.biz/asia/news/',
 			'https://www.blockchaingamer.biz/news/']
		@mass = Array.new
		url.each_with_index do |url, index|
			@mass << agent.get(url)
		end

		@rowsd = Array.new
		@mass[0].css('.module.latest.news').each do |row|
			@m = 0
			rowcss = row.css('.item')
			rowcss.each do |rowf|
			@m = @m + 1
			puts @m 
				if @m != 5
					selection_scrapped(rowf)
				end
			end
		end		
		# mas = @mass[1].body.force_encoding("utf-8")
		# mas =@mass[1].css('.content-container').inner_text
	  @mass[1].css('.content-container article').each do |row|
	    selection_scrapped_two(row)
	  end
		# mas = mas.force_encoding("utf-8")
		# File.open('889.html', 'w'){ |file| file.write mas }
		to_news_trank(@rowsd)
		sleep(5)
		to_news_trank(@datatwo)





 
	end

end
