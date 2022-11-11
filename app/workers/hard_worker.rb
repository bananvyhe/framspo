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
			link = row.css('a').attr('href').to_s
			if link.include? "/#comments"
				puts "coments.."
			else
				pic = row.css('img').attr('src').to_s
				link = 'https://www.pocketgamer.biz'+link
				head = row.css('.qualifier').inner_text.to_s
				# date = row.css('.date').inner_text.to_s
				desc = row.css('h2').inner_text.to_s

				# @s = @s + 2
				# puts @s
				data = {
					:pic => pic,
					:link => link,
					:head => head,
					:date => DateTime.now.strftime('%d/%m/%Y'),
					:desc => desc		
				}
				@rowsd = [*@rowsd, data]
			end
		end

		@datatwo = Array.new
		def selection_scrapped_two(row)
			puts "cooking2.."
			link = row.css('.title a').attr('href').to_s
			if link.include? "/#comments"
				puts "coments.."
			else
				head = row.css('h2').inner_text.to_s
				desc = row.css('.post-summary').inner_text.to_s
				desc = desc[1..-10]
				pic = row.css('.img-holder').attr('data-src').to_s
				data = {
					:pic => pic,
					:link => link,
					:head => head,
					:date => DateTime.now.strftime('%d/%m/%Y'),
					:desc => desc
				}
				@datatwo = [*@datatwo, data]
			end
		end

		@datathree = Array.new
		def selection_scrapped_three(row)
			puts "cooking3.."
			link = row.css('h3 a').attr('href').to_s
			if link.include? "/#comments"
				puts "coments.."
			else
		  	head = row.css('h3').inner_text.to_s
		  	# puts head 
		  	
		  	# puts link 
		  	pic = row.css('img').attr('src').to_s
		  	# puts pic
		  	desc = row.css('.td-excerpt').inner_text.to_s
		  	# puts desc
		  	data = {
					:pic => pic,
					:link => link,
					:head => head,
					:date => DateTime.now.strftime('%d/%m/%Y'),
					:desc => desc
				}
				@datathree = [*@datathree, data]
			end
		end

 		agent = Mechanize.new
 		url=[
 			# 'https://www.pocketgamer.biz/asia/news/',
 			'https://www.blockchaingamer.biz/news/',
 			# 'https://massivelyop.com/category/new-games/',
 			# 'https://massivelyop.com/category/industry/',
 			# 'https://massivelyop.com/category/interview/',
 			'https://massivelyop.com/category/mmorpg/']
		@mass = Array.new
		url.each_with_index do |url, index|
			@mass << agent.get(url)
		end

		# @rowsd = Array.new
		# if @mass[0] != nil
		# 	@mass[0].css('.module.latest.news').each do |row|
		# 		@m = 0
		# 		rowcss = row.css('.item')
		# 		rowcss.each do |rowf|
		# 		@m = @m + 1
		# 		puts @m 
		# 			if @m != 5
		# 				selection_scrapped(rowf)
		# 			end
		# 		end
		# 	end		
		# end

		if @mass[0] != nil
		  @mass[0].css('.content-container article').each do |row|
		    selection_scrapped_two(row)
		  end
		end
		if @mass[1] != nil
			# mas = @mass[2].body.force_encoding("utf-8")
			# File.open('881.html', 'w'){ |file| file.write mas }
		  @mass[1].css('.td_module_16').each do |row|
		    selection_scrapped_three(row)
		  end
		end
		# if @mass[2] != nil
		#   @mass[2].css('.td_module_16').each do |row|
		#     selection_scrapped_three(row)
		#   end 
		# end
		# if @mass[3] != nil
		#   @mass[3].css('.td_module_16').each do |row|
		#     selection_scrapped_three(row)
		#   end 
		# end
		# if @mass[4] != nil
		#   @mass[4].css('.td_module_16').each do |row|
		#     selection_scrapped_three(row)
		#   end 
		# end		
		# to_news_trank(@rowsd)
		# sleep(2)
		to_news_trank(@datatwo)
		sleep(2)
		to_news_trank(@datathree)		
		sleep(2)
		# to_news_trank(@datafour)		
		# sleep(2)
	end
end
		# mas = @mass[1].body.force_encoding("utf-8")
		# mas =@mass[1].css('.content-container').inner_text
		# mas = mas.force_encoding("utf-8")
		# File.open('889.html', 'w'){ |file| file.write mas }