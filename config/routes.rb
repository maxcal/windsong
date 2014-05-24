Windsong::Application.routes.draw do
  resources :posts

  root to: 'pages#home'

  # === Users ===============================================
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get '/users/me', to: 'users#me', as: :current_user
  resources :users, only: [:show, :index] do
    resources :authentications, only: [:destroy], controller: 'users/authentications'
  end

end
