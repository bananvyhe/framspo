# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Sidekiq
install_plugin Capistrano::Sidekiq::Systemd
 
:sidekiq_monit_conf_dir => '/etc/monit/conf.d'
:sidekiq_monit_use_sudo => true
:monit_bin => '/usr/bin/monit'
:sidekiq_monit_default_hooks => true
:sidekiq_monit_group => nil
:sidekiq_service_name => "sidekiq_#{fetch(:application)}"
# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require "capistrano/rvm"
require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit'
set :sidekiq_service_unit_name, 'frmspot'
set :init_system, :systemd
set :upstart_service_name, 'sidekiq_framnspo'
set :sidekiq_processes, 5
set :sidekiq_options_per_process, ["--queue high", "--queue default --queue low"]
require "capistrano/rbenv"
# require "capistrano/chruby"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
# require "capistrano/passenger"
set :rbenv_ruby, '3.0.2'
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
# Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
