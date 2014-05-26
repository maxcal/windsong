class UserPresenter < Presenter

  # How to generically refer to user
  # @return (String)
  def to_s
    user.username.capitalize
  end

  # @return (String) user_path(user)
  def path
    context.user_path(user)
  end

  # @return (String) user_url(user)
  def url
    context.user_url(user)
  end

  # @param opts Hash (optional) hash of arguments passed to `link_to`
  # @return String link_to(user_name, user_path(user), options)
  # @see http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html
  def link opts = {}
    context.link_to(to_s, path, opts)
  end

end