Windsong::Application.routes.draw do
  root to: 'pages#home'

  # === Users ===============================================
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omni_auth_callbacks'
  }
  get '/users/me', to: 'users#me', as: :current_user
  resources :users, only: [:show, :index]
end
