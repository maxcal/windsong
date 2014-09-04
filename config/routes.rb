Windsong::Application.routes.draw do

  scope "(:locale)", locale: /en|sv/ do
    root to: 'pages#home'
  end
  #root to: 'pages#home'

  # === Users ===============================================
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get '/users/me', to: 'users#me', as: :current_user

  resources :users, only: [:show, :index] do
    resources :authentications, only: [:destroy], controller: 'users/authentications'
  end


    # === Stations ============================================
    resources :stations do
      collection do
        get 'find/:hardware_uid', action: :find, as: :find
      end

      resources :observations, only: [:create, :index] do

      end
    end

end
