Windsong::Application.routes.draw do
  root to: 'pages#home'

  # === Users ===============================================
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get '/users/me', to: 'users#me', as: :current_user
  resources :users, only: [:show, :index]
  delete '/users/:user_id/authentications/:id',
         to: 'users/authentications#delete',
         as: :user_authentication

end
