# @nodoc
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  # Check authorization with CanCan
  check_authorization unless :devise_controller?

  before_action :add_home_breadcrumb

  # default url options
  def default_url_options(options={})
    { locale: I18n.locale }
  end

  private

  # Allow username param when creating user accounts
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :remember_me)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:login, :username, :email, :password, :remember_me)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :current_password)
    end
  end

  # If user is denied access then redirect user back after sign in
  def after_sign_in_path_for(resource)
    session["user_return_to"] || root_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def add_home_breadcrumb
    add_breadcrumb I18n.t(:home).capitalize, :root_path
  end

end