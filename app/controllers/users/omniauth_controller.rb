class Users::OmniauthController < ApplicationController
  # Saves the locale in session so that we redirect to current locale after OAuth authentication
  # @example
  #   GET (/:locale)/user/omniauth/:provider(.:format)
  def localized
    session[:omniauth_login_locale] = I18n.locale
    redirect_to user_omniauth_authorize_path(params[:provider])
  end
end