set :application, 'postman'
set :user, 'deployer'
set :repo_url, 'git://github.com/cirope/postman.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :deploy_via, :remote_cache
set :scm, :git

set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p247'

set :linked_files, %w{config/app_config.yml}
set :linked_dirs, %w{log}

set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
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
