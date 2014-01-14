set :stage, :production
set :rails_env, 'production'

role :web, %w{deployer@librujo.com}
role :app, %w{deployer@librujo.com}
role :db,  %w{deployer@librujo.com}

server 'librujo.com', user: 'deployer', roles: %w{web app db}
