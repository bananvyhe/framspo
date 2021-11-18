class HardWorker < ApplicationController
	include Sidekiq::Worker
	wrap_parameters format: [:json, :xml]
	require 'mechanize'
	require 'json'
	require 'httparty'

	def perform
		def selection_scrapped(row)
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
					puts rowf.css('img').attr('src').to_s
					puts rowf.css('a').attr('href').to_s
					puts rowf.css('.qualifier').inner_text.to_s
					puts rowf.css('.date').inner_text.to_s
					puts rowf.css('h2').inner_text.to_s
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
