class UserPresenter < Presenter

  # How to generically refer to user
  def to_s
    user.username.capitalize
  end

  def path
    context.user_path(user)
  end

  def url
    context.user_url(user)
  end

  def link opts = {}
    context.link_to(to_s, path, opts)
  end

end