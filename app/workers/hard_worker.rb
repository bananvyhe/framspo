class HardWorker
  include Sidekiq::Worker

	def perform
		adf = 2*2+6
		puts  adf

	end
 
end
