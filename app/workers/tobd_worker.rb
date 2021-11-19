class TobdWorker < ApplicationController
  include Sidekiq::Worker
  require 'json'
  require 'uri'
  require 'openssl'
  require 'httparty' 
  def perform (pic, head, desc, date, link, tokenrapid)

    # puts desc

    def tranklukate(ina, tokenrapid)
      puts tokenrapid
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
        puts headfin
    end

    headfin = tranklukate(head, tokenrapid )
    contentfin = tranklukate(head, tokenrapid )

    puts headfin
    puts contentfin
    sleep(1)




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