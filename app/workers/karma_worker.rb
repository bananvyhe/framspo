class KarmaWorker < ApplicationController
  include Sidekiq::Worker
 
  def perform  
 
  end
end