set :application, 'librujo.com'
set :user, 'deployer'
set :repo_url, 'git://github.com/cirope/postman.git'

set :format, :pretty
set :log_level, :info

set :deploy_to, "/var/www/#{fetch(:application)}"
set :deploy_via, :remote_cache
set :scm, :git

set :linked_files, %w{config/app_config.yml}
set :linked_dirs, %w{log}

set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p353'

set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :finishing, 'deploy:cleanup'

  # TODO: remove when whenever add support to Capistrano 3
  desc 'Update crontab with whenever'
  after :finishing, 'deploy:cleanup' do
    on roles(:all) do
      within release_path do
        execute :bundle, :exec, "whenever --update-crontab #{fetch(:application)}"
      end
    end
  end
end
