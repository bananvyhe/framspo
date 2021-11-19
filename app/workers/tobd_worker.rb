class TobdWorker < ApplicationController
  include Sidekiq::Worker
  require 'json'
  require 'uri'
  require 'openssl'
  require 'httparty' 
  def perform (pic, head, desc, date, link, tokenrapid)

    # puts desc
    @m = 0
    def tranklukate(ina, tokenrapid)
      @m = @m + 1
      puts @m
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
        # puts headfin
    end

    headfin = tranklukate(head, tokenrapid).to_s
    contentfin = tranklukate(desc, tokenrapid).to_s

    sleep(1)
    @news = News.new({:pic => pic, :head => headfin,:desc => contentfin,:date => date,:link => link})
    @news.save

    # puts headfin


     # @headersb = {
     #    "Content-Type" => "application/json",
     #    "Authorization" => tokenrapid 
     #  }

   #  def tranklukator(zap) 
   #    puts "tranklufication..."
   #    bodyb = {
   #      "folderId"=>"b1g86cba4bfmnhhsnobp",
   #      "texts"=> zap,
   #      "targetLanguageCode"=>"ru"
   #    }
   #    resp = HTTParty.post("https://translate.api.cloud.yandex.net/translate/v2/translate", headers: @headersb, body: bodyb.to_json)
   #    render = JSON.parse resp.to_s 
   #    out = render["translations"]
   #    tex = out[0]
   #    headfin = tex.slice("text")['text']
   #  end

   #  #separate translated phrase from responce
   #  headfin = tranklukator head
   #  contentfin = tranklukator content
   #  sleep(1)

  	# @news = News.new({:imglink => imglink, :head => headfin,:content => contentfin,:datepost => datepost,:link => link})
  	# @news.save
 
	end
end