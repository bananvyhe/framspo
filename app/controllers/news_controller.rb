class NewsController < ApplicationController
	skip_before_action :verify_authenticity_token
	require 'net/http'
	require 'uri'
  def index
  	@news = News.all 
		render json: @news.order(created_at: :desc)
  end

	def create 
		# curl -d "{\"yandexPassportOauthToken\":\"Rails.application.credentials.yaOauth\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens"

		uri = URI.parse("https://iam.api.cloud.yandex.net/iam/v1/tokens")
		request = Net::HTTP::Post.new(uri)

		request.body = JSON.dump({
		  "yandexPassportOauthToken" => Rails.application.credentials.yaOauth
		})
		req_options = {
		  use_ssl: uri.scheme == "https",
		}
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  @tokwars =  http.request(request).body
		end
	# response.code
	# response.body
		formj = JSON.parse(@tokwars)
		tokenrapid = "bearer " + formj['iamToken']

	# ycc =  `yc iam create-token`
	# print ycc
	# tokenrapid = "bearer " + ycc
	# print tokenrapid
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