class NewsController < ApplicationController
	skip_before_action :verify_authenticity_token

  def index
  	@news = News.all 
		render json: @news.order(created_at: :desc)
  end

	def create 

		tokenrapid = News.tokenmake
		params.require(:_json).each do |d|
    	pic = d[:pic].to_s
      head = d[:head].to_s
      desc = d[:desc].to_s
      date = d[:date].to_s
      link = d[:link].to_s

    	unless News.find_by(pic: pic)  
      	TobdWorker.perform_async(pic, head, desc, date, link, tokenrapid)
			end
		end
	end 

	def fullnews
		puts "===-----------fullnews----------===="
		puts params[:id]

		link = News.find(params[:id])  
		 if link.fullarticle.nil?
			agent = Mechanize.new
	    url= 'https://www.pocketgamer.biz'+link.link 
	    page = agent.get(url)
	    tokenr = News.tokenmake

			article = page.css('.body').to_s
			getp = article.gsub '<div class="body" itemprop="articleBody">', ''
			get = getp.gsub '</div>', ''
			get =	get[1..-2]
	    imageget = page.at_css('#fb-image').attr('src').to_s
	    puts get
			artbody = News.tranklukate(get, tokenr)
	    getp =  artbody.gsub '</рисунок>', '</figure>'
	    getp = getp.gsub '<рисунок>', '<figure>'
	    getp =  getp.gsub '</сильный>', '</strong>'
	    getp = getp.gsub '<сильный>', '<strong>'
	    getp = getp.gsub '<заголовок iframe= "Видеоплеер YouTube"', '<iframe title="YouTube video player"'
	    getp = getp.gsub 'ширина=', 'width='
	    getp = getp.gsub 'высота=', 'height='
	    getp = getp.gsub 'порядок кадров=', 'frameborder='
	  	link.biglink = imageget
 			link.fullarticle = getp
 			link.save!
		end
		# puts getp
		# puts imageget
		render json: link
# 
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