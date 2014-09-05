Windsong::Application.routes.draw do

  # We need to define devise_for just omniauth_callbacks:uth_callbacks otherwise it does not work with scoped locales
  # see https://github.com/plataformatec/devise/issues/2813
  devise_for :users, skip: [:session, :password, :registration, :confirmation], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope "(:locale)", locale: /en|sv/ do
    root to: 'pages#home'

    # === Users ===============================================
    get 'user/omniauth/:provider' => 'users/omniauth#localized', as: :localized_omniauth

    devise_for :users, skip: :omniauth_callbacks do
      # We define here a route inside the locale thats just saves the current locale in the session
    end
    get '/users/me', to: 'users#me', as: :current_user
    resources :users, only: [:show, :index] do
      resources :authentications, only: [:destroy], controller: 'users/authentications'
    end

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
