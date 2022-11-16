class UsersController < ApplicationController
	before_action :authorize_access_request!
	
  def me
    render json: current_user.as_json(only: [:id, :email, :role])
  end	

	def deluser
		@user = User.find(params[:id])
	  if @user.destroy
	  	render json: @user, status: :ok
	  else 	
	  end	 
	end	  
end
