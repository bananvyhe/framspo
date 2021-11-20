class TobdWorker < ApplicationController
  include Sidekiq::Worker
  require 'json'
  require 'httparty' 
  def perform (pic, head, desc, date, link, tokenrapid)

    @n = 0
    def tranklukate(ina, tokenrapid)
      # puts tokenrapid
      @n = @n + 1
      puts @n.to_s + "tranklucating.."
        @headersb = {
          "Content-Type" => "application/json",
          "Authorization" => tokenrapid
        }

        bodyb = {
          "folderId"=>"b1g86cba4bfmnhhsnobp",
          "texts"=> ina,
          "targetLanguageCode"=>"ru"
        }
         
        resp = HTTParty.post("https://translate.api.cloud.yandex.net/translate/v2/translate", headers: @headersb, body: bodyb.to_json)
        render = JSON.parse resp.to_s 
        out = render["translations"]
        tex = out[0]
        headfin = tex.slice("text")['text']
    end

    headfin = tranklukate(head, tokenrapid)
    sleep(1)
    contentfin = tranklukate(desc, tokenrapid)

    @news = News.new({:pic => pic, :head => headfin,:desc => contentfin,:date => date,:link => link})
    @news.save
 
	end
end