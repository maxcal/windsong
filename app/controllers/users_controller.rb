class UsersController < ApplicationController
  before_filter :set_user, only: [:show]

  before_filter :set_user, only: :show
  respond_to :json

  before_action do
    add_breadcrumb User.model_name.human(count: 2), :users_path
  end

  # @example
  #   GET /users/:id
  def show
    add_breadcrumb @user.username
  end

  # @example
  #   GET /users/
  def index
    @users = User.all
  end

  # User profile page
  # @example
  #   GET /users/me
  def me
    add_breadcrumb I18n.t('users.me.my_profile').capitalize
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end