# Load DSL and set up stages
require "capistrano/setup"
set :stage, :production
# Include default deployment tasks
require "capistrano/deploy"
set :stage, :production
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
require "capistrano/rbenv"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require 'capistrano/passenger/no_hook'
require 'capistrano/sidekiq'

require 'capistrano/sidekiq/monit'
require "whenever/capistrano"
set :sidekiq_service_unit_name, 'farmspot'
set :init_system, :systemd 
set :upstart_service_name, 'sidekiq_farmspot'
set :sidekiq_processes, 5
set :sidekiq_options_per_process, ["--queue high", "--queue default --queue low"]

# require "capistrano/chruby"




# Load custom tasks from `lib/capistrano/tasks` if you have any defined
# Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
