require 'rvm/capistrano'
require 'bundler/capistrano'
load "deploy/assets"

#RVM and bundler settings
set :bundle_cmd, "/home/deploy/.rvm/gems/ruby-2.0.0-p247@global/bin/bundle"
set :bundle_dir, "/home/deploy/.rvm/gems/ruby-2.0.0-p247/gems"
set :rvm_ruby_string, :local


#general info
set :user, 'deploy'
set :domain, 'www.whybully.com'
set :applicationdir, "/var/www/whybully.com"
set :scm, 'git'
set :application, "whybully"
set :repository,  "git@git.geekli.st:hack4goodnyc/bully-report.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :deploy_via, :remote_cache

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
#deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

#addition settings. mostly ssh
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
ssh_options[:paranoid] = false
default_run_options[:pty] = true
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc 'Re-establish database.yml'
  task :set_database_symlink do
    run "rm -fr #{current_path}/config/database.yml && cd #{current_path}/config && ln -nfs #{shared_path}/database.yml database.yml" 
  end
end

after "bundle:install", "deploy:symlink"
after "deploy:symlink", "deploy:set_database_symlink"

