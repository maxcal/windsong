class AuthenticationPresenter < Presenter

  # @return (String)
  def path
    context.user_authentication_path(
        user_id: @authentication.user.to_param,
        id: @authentication.to_param
    )
  end

end