class SigninController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authorize_access_request!, only: [:destroy]

	def create
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      payload  = { user_id: user.id, aud: [user.role] }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true,
         namespace: "user_#{user.id}")
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf] }
    else
      not_authorized
    end
  end
  def destroy
  	puts "122222destroy222222222"
    session = JWTSessions::Session.new(payload: payload, namespace: "user_#{payload['user_id']}")
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: 'Cannont find such email/password combination' }, status: :not_found
  end  
end
