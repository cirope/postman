Rails.application.routes.draw do
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
  resources :tenants, shallow: true do
    resources :tickets
  end
  resources :tickets, only: :index do
    resources :feedbacks, constraints: { id: /.*/ }, except: [:destroy]
    resources :replies
  end

  root 'sessions#new'
end
