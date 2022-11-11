class MyItemsController < ApplicationController
	before_action :authorize_access_request!
  def index

  	# @MyItem = MyItem.find(payload['user_id'])
@MyItem = User.joins(:myItem).find(payload['user_id'])

		render json: @MyItem.myItem.loa


  end	
end
