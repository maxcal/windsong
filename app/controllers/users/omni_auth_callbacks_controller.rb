class Users::OmniAuthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    auth_hash = request.env["omniauth.auth"]
    @user = User.find_or_create_from_omniauth_hash(auth_hash)

    @authentication = @user.authentications.find_or_initialize_from_omniauth_hash(auth_hash)
    # Update existing authentication or persist a new one

    @authentication.update_with_omniauth_hash(auth_hash)

    flash[:success] = "You signed in successfully!"
    sign_in_and_redirect(:user, @user)
  end

end