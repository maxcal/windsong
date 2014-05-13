Windsong::Application.routes.draw do

  root to: 'pages#home'

  # Users
  devise_for :users
  resources :users, only: [:show, :index]

end
