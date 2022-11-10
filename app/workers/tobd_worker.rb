class TobdWorker < ApplicationController
  include Sidekiq::Worker
  require 'json'
  require 'httparty' 
  def perform (pic, head, desc, date, link, tokenrapid)
    # tem = News.limit(200).order(created_at: :desc)
    # findrec = false

    # $tem.each do |item|
    #   if item.link == link
    #     findrec = true
    #     puts findrec
    #     break
    #   end
    # end

    # if findrec == false
      # puts "trank"
      headfin = News.tranklukate(head, tokenrapid)
      sleep(1)
      contentfin = News.tranklukate(desc, tokenrapid)
     
      @news = News.new({:pic => pic, :head => headfin,:desc => contentfin,:date => date,:link => link})
      @news.save
    # end
    # unless News.find_by(link: link)  
    #   headfin = News.tranklukate(head, tokenrapid)
    #   sleep(1)
    #   contentfin = News.tranklukate(desc, tokenrapid)
     
    #   @news = News.new({:pic => pic, :head => headfin,:desc => contentfin,:date => date,:link => link})
    #   @news.save


    # end
	end
end