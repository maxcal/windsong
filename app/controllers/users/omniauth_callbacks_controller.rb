class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  before_action -> { I18n.locale = session[:omniauth_login_locale] || I18n.default_locale }




  def facebook
    handle_redirect('devise.facebook_data', 'Facebook')
  end

  def handle_redirect(_session_variable, kind)
    # here we force the locale to the session locale so it switches to the correct locale
    I18n.locale = session[:omniauth_login_locale] || I18n.default_locale
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
  end


  private

  def user(auth_hash = request.env["omniauth.auth"])
    @user = User.find_or_create_from_omniauth_hash(auth_hash)
    # Update existing authentication or persist a new one
    @authentication = @user.authentications.find_or_initialize_from_omniauth_hash(auth_hash)
    @authentication.update_with_omniauth_hash(auth_hash)
    @user
  end

end