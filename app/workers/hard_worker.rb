class HardWorker < ApplicationController
  include Sidekiq::Worker

	def perform
		adf = Post.all
 		

	end
 
end
