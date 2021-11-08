class HardWorker
  include Sidekiq::Worker

	def perform
		adf = Post.all
 		

	end
 
end
