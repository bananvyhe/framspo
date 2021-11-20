class NewsController < ApplicationController
	skip_before_action :verify_authenticity_token

  def index
  	@news = News.all 
		render json: @news.order(created_at: :desc)
  end

	def create 
		tokenrapid = "bearer " + %x{yc iam create-token}

		params.require(:_json).each do |d|
    	pic = d[:pic].to_s
      head = d[:head].to_s
      desc = d[:desc].to_s
      date = d[:date].to_s
      link = d[:link].to_s

    	unless News.find_by(link: link)  
      	TobdWorker.perform_async(pic, head, desc, date, link, tokenrapid)
			end
		end
	end 

	private
	  def news_params
    params.require(:news).permit(:pic, :link, :head, :date, :desc, :tokenrapid)
  end
end