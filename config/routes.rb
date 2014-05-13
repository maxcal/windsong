Windsong::Application.routes.draw do

  root to: 'pages#home'

  get '/users/me', to: 'users#me', as: :current_user
  # Users
  devise_for :users
  resources :users, only: [:show, :index]
end
