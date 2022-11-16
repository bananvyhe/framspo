Rails.application.routes.draw do
  # match '*path', via: [:options], to: lambda {|_| [204, { 'Content-Type' => 'text/plain' }]}
  resources :cors
  # get 'news/index'

  root to: 'welcome#index'


  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy
  get :news, to: "news#index" 
  get 'me', controller: :users, action: :me 

  # get '/*path', to: 'welcome#index' 
  get 'admin/users', controller: 'admin/users', action: :all
get 'admin/all', controller: 'welcome#index' 

  # namespace :admin do
  #   resources :users, controller: 'admin/users'
  # end

  require "sidekiq/web"


 resources :join

  #

   # get '/*path', to: 'welcome#index' 
  resources :todos
  # resources :join
 	# resources :news do
  post :news, to: "news#create"
  post :fullnews, to: "news#fullnews"
  # end

	# post :news, to: "news#create"
  get '/404', to: 'welcome#index'

  # get '/admin/users', to: 'welcome#index' 



  resources :my_items  do 
    member do
      post :use_item
      patch :move
    end
  end 
  get '/my_items', to: 'my_items#index' 
  post '/incloareg', to: 'my_items#incloareg'
  post '/decloareg', to: 'my_items#decloareg' 
# get 'page_controller/*path', to: 'welcome#index', format: false

  # get 'errors/not_found'
  # get 'errors/internal_server_error'   
  # get 'welcome/index'
  resources :users
  delete 'deluser/:id', to: "users#deluser"
	# get 'app', to: 'welcome#index'
 #  match "/404", :to => "errors#not_found", :via => :all
	# match "/500", :to => "errors#internal_server_error", :via => :all
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
