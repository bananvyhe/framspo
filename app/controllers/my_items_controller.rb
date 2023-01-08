class MyItemsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authorize_access_request!, only: [:index, :incloareg, :decloareg, :pickdrop, :menuget, :move]
	before_action :set_my_item, only: [ :show, :edit, :update, :destroy, :move]
  def index
		@MyItem = User.find(payload['user_id'])
		
		render json: @MyItem.loa
  end	

	def move
		# @user = MyItem.where('user_id = ?', payload['user_id']).sorted.update(my_item_params)
 
		# @user = MyItem.where('user_id = ?', payload['user_id']).sorted.insert_at(my_item_params)
		# @user = User.find(payload['user_id']).myItems.update(my_item_params) 
		# pos = my_item_params[:position]
		# pos = pos.to_i
 
		# @user = @item.insert_at(my_item_params[:position].to_i)
		# @user = @item.update(my_item_params)
 		# @user = MyItem.where('user_id = ?', payload['user_id']).update(my_item_params)
 		# .find(params[:id]).insert_at(pos)
@user = MyItem.find(my_item_params[:my_item_id].to_i).insert_at(my_item_params[:position].to_i) 
     # @user = MyItem.update(my_item_params)
    puts "==----move---=="
    puts my_item_params[:my_item_id]
    puts my_item_params.inspect
    # puts my_item_params.id
    puts @user.inspect
    puts "==----move---=="
  end   
  def menuget
  	puts "==----menuget---=="

  	@invfind = MyItem.where('user_id = ?', payload['user_id'])
  		.joins(:listitem)
  		.select('my_items.id', 'qty', 'position', 'listitems.title', 'listitems.desc', 'listitems.item', 'listitems.rate', 'listitems.id as listid' )

  # 	user = User.find(payload['user_id'])

		# my_items = user.myItems.includes(:listitem).group(:listitem_id) 
 
		@invfind = @invfind.sorted
			# @invfind = @invfind
  	# @invfind = MyItem.where('listitem_id = ?', params[:id]).joins(:user).where('users.id = ?', payload['user_id']) 
  		# .select(' qty, listitems.title')
  		# .joins(:listitem)
  		# .joins(:user)
  		# .where('user_id = ?', payload['user_id'])
  	puts @invfind.inspect

  	# @invfind.each do |item| 
  	# 	puts item.listitem.inspect
  	# end
  	puts "==----menuget---==" 
  	render json: @invfind
  end
  def pickdrop
  	# puts "---====pickdrop=====----"
  	# puts params[:id]
  	usfind = User.find(payload['user_id'])
  	@invfind = MyItem.where('listitem_id = ?', params[:id]).joins(:user).where('users.id = ?', payload['user_id']).first 
  	@@drop.each do |item| 
  		puts item.inspect
  		if item.fetch("id") == params[:id]

  			# usfind = User.find(payload['user_id'])
  			
  			if !@invfind 
  				itfind = Listitem.find(params[:id])
  				usfind.listitems << itfind
  				# puts "---------"
  				# puts @invfind.inspect 
  				addit = usfind.myItems.where('listitem_id = ?', params[:id]).first
  				# puts addit.inspect 
  				addit.qty += 1
  				addit.save
  				# puts usfind.myItems.inspect 
  				puts "item added"
  			elsif 
  				@invfind.qty += 1 
  				# puts @invfind.inspect 
  				@invfind.save
  				# puts item
  				# puts "item already exist"
  			end
  			@@drop.delete(item)
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
  def set_my_item
    # binding.pry
     @item = MyItem.find_by_user_id(payload['user_id'])
  end	
 def my_item_params
    params.require(:my_item).permit( :id, :my_item_id, :position, :qty, :listid )
  end		 
end
