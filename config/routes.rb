Rails.application.routes.draw do
	require "sidekiq/web"

	root to: 'welcome#index'
  get 'welcome/index'
  resources :users
	get 'app', to: 'welcome#index'
  match "/404", :to => "errors#not_found", :via => :all
	match "/500", :to => "errors#internal_server_error", :via => :all
  Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)

    login_hash = ::Digest::SHA256.hexdigest(username)
    password_hash = ::Digest::SHA256.hexdigest(password)

    ActiveSupport::SecurityUtils.secure_compare(login_hash, ::Digest::SHA256.hexdigest(Rails.application.credentials.username)) &
      ActiveSupport::SecurityUtils.secure_compare(password_hash, ::Digest::SHA256.hexdigest(Rails.application.credentials.password))
  end # if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
