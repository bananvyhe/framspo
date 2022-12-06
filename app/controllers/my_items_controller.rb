class MyItemsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authorize_access_request!, only: [:index, :incloareg, :decloareg]

  def index
		@MyItem = User.find(payload['user_id'])
		
		render json: @MyItem.loa
  end	

  def getdrop
  	@items = Dropitem.joins(:mob).where('mobs.name = ?', 'pumpkin').includes(:listitem) 
  	# @items = Dropitem.includes(:listitem) 
  	# @items = Dropitem.joins(:mob).joins(:listitem).where('mobs.name = ?', 'pumpkin')  
  	# @items.inspect
  	drop = []
		@items.each do |item| 
		  puts item.listitem.inspect
		  rate = item.listitem.rate
		  puts rate
		  allchance = 100/rate
		  calc = rand(1..allchance.to_i)
		  # puts item.listitem
		  puts calc
		  if calc = 1
		  	drop << item 
		  end
		end
 		puts drop.inspect
  	# @items = Listitem.find(4)
  	render json: @items
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
