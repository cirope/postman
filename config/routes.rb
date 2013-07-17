Postman::Application.routes.draw do
  # Sessions
  get    'login',    to: 'sessions#new',     as: 'login'
  post   'sessions', to: 'sessions#create',  as: 'sessions'
  delete 'logout',   to: 'sessions#destroy', as: 'logout'

  # Profiles
  get   'profile', to: 'profiles#edit', as: 'profile'
  patch 'profile', to: 'profiles#update'

  # Resources
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :tenants
  resources :tickets

  root 'sessions#new'
end
