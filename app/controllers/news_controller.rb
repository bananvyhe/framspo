class NewsController < ApplicationController
	skip_before_action :verify_authenticity_token

  def index
# mem = GetProcessMem.new
  	# puts mem.inspect
  	puts "==========="
  	@news = News.limit(16).order(created_at: :desc).offset(params[:pos])

puts @news.inspect
		# render json: @news.order(created_at: :desc).limit(16).offset(params[:pos])
		render json: @news
		  	puts "||||||||||"
  	# puts mem.inspect
  end

	def create 
		getrecords = News.limit(200).order(created_at: :desc)
		puts "rec"
		tokenrapid = News.tokenmake
		params.require(:_json).each do |d|
			findrec = false
      link = d[:link].to_s			
	    getrecords.each do |item|
	      if item.link == link
	        findrec = true
	        puts findrec
	        break
	      end
	    end 

	    if findrec == false
	    	pic = d[:pic].to_s
	      head = d[:head].to_s
	      desc = d[:desc].to_s
	      date = d[:date].to_s

				TobdWorker.perform_async(pic, head, desc, date, link, tokenrapid)
			end
			
		end
	end 

	def fullnews
		puts "===-----------fullnews----------===="
		puts params[:id]

		full = News.find(params[:id]) 
		 
		 if full.fullarticle.nil?

			agent = Mechanize.new
	    url = full.link 

	    page = agent.get(url)
	    tokenr = News.tokenmake
	 #    get = page.css('.body').to_s
	 #    get = get.force_encoding("utf-8")
		# File.open('777.html', 'w'){ |file| file.write get } 
			url = url.to_s
			compare = url[0..20]

 			if compare == 'https://www.blockchai'
				# puts "entry"
 				@get = page.css('.entry-content').to_s
 				# @get = get[58..-7]
 			elsif compare == 'https://www.pocketgam'
				# puts "body"
 				@get = page.css('.body').to_s
 				# getp = article.gsub '<div class="body" itemprop="articleBody">', ''
				# get = getp.gsub '</div>', ''
				# @get =	get[1..-4]
			elsif compare == 'https://massivelyop.c'
 
				@get = page.css('.td-post-content').to_s

			else
 			end
 			
			artbody = News.tranklukate(@get, tokenr) 
			getp =  artbody.gsub 'a href="/','a href="https://massivelyop.com/'
			# puts artbody
 			full.fullarticle = getp
 			full.save!
				# "https://massivelyop.com/"
			# getp =  artbody.gsub '<загрузка iframe= "ленивый" заголовок=','<iframe loading="lazy" title='
			# getp =  getp.gsub '<идентификатор ul=','<ul '
			# getp =  getp.gsub '<класс рисунка=','<figure '
			# getp =  getp.gsub '<загрузка img= "', '<img loading="lazy" '
			# getp =  getp.gsub '<ли>', '<li>'
			# getp =  getp.gsub '</ли>', '</li>'
	  #   getp =  getp.gsub '</рисунок>', '</figure>'
	  #   # getp =  getp.gsub '<класс рисунка="','<figure '
	  #   getp =  getp.gsub '<класс div="','<div '
	  #   getp = getp.gsub '<рисунок>', '<figure>'
	  #   getp =  getp.gsub '</сильный>', '</strong>'
	  #   getp = getp.gsub '<сильный>', '<strong>'
	  #   getp = getp.gsub '<заголовок iframe= "Видеоплеер YouTube"', '<iframe title="YouTube video player"'
	  #   getp = getp.gsub 'ширина=', ''
	  #   getp = getp.gsub 'высота=', ''
	  #   getp = getp.gsub 'порядок кадров=', 'frameborder='
		end
		# puts getp
		# puts imageget

			render json: full
    # puts imageget.to_s
    # resp = page.body.force_encoding("utf-8")
		# File.open('777.html', 'w'){ |file| file.write resp }

		# @rowsd = Array.new

		# def selection_scrapped(row)
		# 	puts "cooking.."
		# 	pic = row.css('img').attr('src').to_s
		# 	link = row.css('a').attr('href').to_s
		# 	head = row.css('.qualifier').inner_text.to_s
		# 	date = row.css('.date').inner_text.to_s
		# 	desc = row.css('h2').inner_text.to_s

		# 	data = {
		# 		:pic => pic,
		# 		:link => link,
		# 		:head => head,
		# 		:date => date,
		# 		:desc => desc				
		# 	}
		# 	@rowsd = [*@rowsd, data]
		# end

 	# 	agent = Mechanize.new
 	# 	url='https://www.pocketgamer.biz/asia/news/'
 	# 	page = agent.get(url)
		# @rowsd = Array.new
		# page.css('.module.latest.news').each do |row|

		# 	@m = 0
		# 	rowcss = row.css('.item')
		# 	rowcss.each do |rowf|
		# 	@m = @m + 1
		# 	puts @m 
		# 		if @m != 5
		# 			selection_scrapped(rowf)
		# 		end
		# 	end
		# end
		# headers = {
		# 	"Content-Type" => "application/json"  
		# }

	end

	private
	  def news_params
    params.require(:news).permit(:pic, :link, :head, :date, :desc, :tokenrapid)
  end
end