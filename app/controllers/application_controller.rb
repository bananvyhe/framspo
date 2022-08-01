class ApplicationController < ActionController::Base
	include JWTSessions::RailsAuthorization
	rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  # protect_from_forgery unless: -> { request.format.json? }
      protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }
	private
  def set_html_format
    request.format = :html
  end
  def set_default_format
    request.format = :json

  end
  def current_user
    @current_user ||= User.find(payload['user_id'])
  end  
  
  def not_authorized
    render json: { error: 'ошибка jwt авторизации' }, status: :unauthorized
  end

  def forbidden
    render json: { error: 'Forbidden' }, status: :forbidden
  end
end
