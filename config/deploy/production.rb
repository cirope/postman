set :stage, :production
role :all, %w{librujo.com}
server 'librujo.com', user: 'deployer'
