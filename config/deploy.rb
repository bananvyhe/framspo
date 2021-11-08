# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"
# namespace :sidekiq do
#   task :quiet do
#     on roles(:app) do
#       puts capture("pgrep -f 'sidekiq' | xargs kill -TSTP") 
#     end
#   end
#   task :restart do
#     on roles(:app) do
#       execute :sudo,  :restart, :workers
#     end
#   end
# end
set :application, "farmspot"
set :repo_url, "git@github.com:bananvyhe/framspo.git"
set :stage, :production
set :branch, "main"
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/apps/farmspot"
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto


namespace :deploy do
	desc "Update cron jobs"
  task :update_crontab do
  	on roles(:deploy) do
  		run "cd #{release_path} && whenever --update-crontab farmspot"
  	end
  end
    desc "Clear cron jobs"
  task :clear_crontab do
  	on roles(:deploy) do
    	run "cd #{release_path} && whenever --clear-crontab farmspot"
  	end
  end
end
after 'deploy:starting', 'deploy:clear_crontab'
after 'deploy:starting', 'deploy:update_crontab'

SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "bundle exec sidekiqctl"

namespace :sidekiq do
  desc 'Quiet sidekiq (stop fetching new tasks from Redis)'
  task :quiet do
    on roles fetch(:sidekiq_roles) do
      # See: https://github.com/mperham/sidekiq/wiki/Signals#tstp
      execute :systemctl, '--user', 'kill', '-s', 'SIGTSTP', fetch(:sidekiq_systemd_unit_name), raise_on_non_zero_exit: false
    end
  end

  desc 'Stop sidekiq (graceful shutdown within timeout, put unfinished tasks back to Redis)'
  task :stop do
    on roles fetch(:sidekiq_roles) do
      # See: https://github.com/mperham/sidekiq/wiki/Signals#tstp
      execute :systemctl, '--user', 'kill', '-s', 'SIGTERM', fetch(:sidekiq_systemd_unit_name), raise_on_non_zero_exit: false
    end
  end

  desc 'Start sidekiq'
  task :start do
    on roles fetch(:sidekiq_roles) do
      execute :systemctl, '--user', 'start', fetch(:sidekiq_systemd_unit_name)
    end
  end

  desc 'Restart sidekiq'
  task :restart do
    on roles fetch(:sidekiq_roles) do
      execute :systemctl, '--user', 'restart', fetch(:sidekiq_systemd_unit_name)
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:updated', 'sidekiq:stop'
after 'deploy:published', 'sidekiq:start'
after 'deploy:published', 'passenger:restart'
after 'deploy:failed', 'sidekiq:restart'

# Default value for :pty is false
# set :pty, true
set :pty,  false
# set :rbenv_map_bins, %w{rake gem bundle ruby rails sidekiq sidekiqctl}
set :rbenv_map_bins, %w{rake gem bundle ruby rails sidekiq sidekiqctl}
# Default value for :linked_files is []
append :linked_files, "config/database.yml"
set :linked_files, %w{config/master.key}
# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, '.bundle'
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 2

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
