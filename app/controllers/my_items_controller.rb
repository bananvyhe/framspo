class MyItemsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authorize_access_request!, only: [:index, :incloareg, :decloareg, :pickdrop]

  def index
		@MyItem = User.find(payload['user_id'])
		
		render json: @MyItem.loa
  end	
  def pickdrop
  	# puts "---====pickdrop=====----"
  	# puts params[:id]
  	usfind = User.find(payload['user_id'])
  	@@drop.each do |item| 
  		puts item.inspect
  		if item.fetch("id") == params[:id]

  			# usfind = User.find(payload['user_id'])
  			invfind = MyItem.where('listitem_id = ?', params[:id]).joins(:user).where('users.id = ?', payload['user_id']) 
  			if invfind.empty?
  				itfind = Listitem.find(params[:id])
  				usfind.listitems << itfind  				
  				puts "item added"
  			elsif 

  				puts "item already exist"
  			end
  					
				puts "true"
				puts invfind 
				puts "true"
  		# 	itfind = Listitem.find(params[:id])

  		# 	usfind.listitems << itfind
  		# puts "true"
  		# puts itfind.inspect



  		elsif 
  		puts 	"false"
  		end
  	end
  end

 


  def getdrop
  	@items = Dropitem.joins(:mob).where('mobs.name = ?', 'pumpkin').includes(:listitem) 
  	# @items = Dropitem.includes(:listitem) 
  	# @items = Dropitem.joins(:mob).joins(:listitem).where('mobs.name = ?', 'pumpkin')  
  	# @items.inspect
  	@@drop = []
		@items.each do |item| 
		  puts item.listitem.inspect
		  rate = item.listitem.rate
		  puts rate
		  allchance = 100/rate
		  calc = rand(1..allchance.to_i)
		  # puts item.listitem
		  puts calc
		  if calc == 1
		  	@@drop << item.listitem.as_json(only: [:id, :title, :desc, :item, :rate])
		  end
		end

 		# puts drop.inspect
  	# @items = Listitem.find(4)
  	render json: @@drop
  end

  def incloareg
  	loain = params[:loa].to_i
  	@loa = User.find(payload['user_id'])
  	@loa.loa += loain
  	puts @loa.loa
  	@loa.save
  	render json: @loa
  end

  def decloareg
  	loain = params[:loa].to_i
  	@loa = User.find(payload['user_id'])
  	@loa.loa -= loain
  	puts @loa.loa
  	@loa.save
  	render json: @loa
  end

	private
  	# def MyItem_params
   #  	params.permit(:loa)
  	# end			 
end
