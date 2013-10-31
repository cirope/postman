set :stage, :production
set :rails_env, 'production'

role :all, %w{librujo.com}

server 'librujo.com', user: 'deployer', roles: %w{web app db}
