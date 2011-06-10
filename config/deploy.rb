$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

# RVM settings
set :rvm_ruby_string, 'ruby-1.9.2-p180@root'
set :rvm_type, :user

require 'bundler/capistrano'

# define some variables
set :user, 'ubuntu'
set :domain, '79.125.29.125'
set :applicationdir, "/home/ubuntu/www/alexpearce/public/"
 
# scm config
set :scm, 'git'
set :repository,  "selene:root.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
 
# server roles
role :web, domain
role :app, domain
role :db,  domain, :primary => true
 
# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export
 
# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows

#set :use_sudo, false
 
# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end