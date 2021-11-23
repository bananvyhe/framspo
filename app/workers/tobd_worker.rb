class TobdWorker < ApplicationController
  include Sidekiq::Worker
  require 'json'
  require 'httparty' 
  def perform (pic, head, desc, date, link, tokenrapid)

    headfin = News.tranklukate(head, tokenrapid)
    sleep(1)
    contentfin = News.tranklukate(desc, tokenrapid)

    @news = News.new({:pic => pic, :head => headfin,:desc => contentfin,:date => date,:link => link})
    @news.save
	end
end