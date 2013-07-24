require 'bundler/capistrano'

set :whenever_command, 'bundle exec whenever --set environment=production'
require 'whenever/capistrano'

set :sidekiq_cmd, 'bundle exec sidekiq'
require 'sidekiq/capistrano'

default_run_options[:shell] = '/bin/bash --login'

server 'librujo.com', :web, :app, :db, primary: true

set :application, 'postman'
set :user, 'deployer'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :repository,  'https://github.com/cirope/postman'
set :branch, 'master'
set :scm, :git

after 'deploy:restart', 'deploy:cleanup'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  end
  after 'deploy:finalize_update', 'deploy:symlink_config'

  desc 'Make sure local git is in sync with remote.'
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts 'WARNING: HEAD is not the same as origin/master'
      puts 'Run `git push` to sync changes.'
      exit
    end
  end
  before 'deploy', 'deploy:check_revision'

  desc 'Creates the synmlink to tmp/pids'
  task :create_tmp_pids_symlink, roles: :app, except: { no_release: true } do
    run "mkdir -p #{release_path}/tmp"
    run "mkdir -p #{shared_path}/tmp/pids"
    run "ln -nfs #{shared_path}/tmp/pids #{release_path}/tmp/pids"
  end
  #after 'deploy:update_code', 'deploy:create_tmp_pids_symlink'
end
