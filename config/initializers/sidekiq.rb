
Sidekiq::Extensions.enable_delay!
Sidekiq.configure_server do |config|
	config.redis = { url: 'redis://127.0.0.1:6379/sidekiq_farm', namespace: "sidekiq_farmspot" }
end

Sidekiq.configure_client do |config|
	config.redis = { url: 'redis://127.0.0.1:6379/sidekiq_farm', namespace: "sidekiq_farmspot" }
end