class UsersController < ApplicationController
  before_filter :set_user, only: [:show]

  add_breadcrumb "Users", :users_path
  respond_to :json

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
    add_breadcrumb "My profile"
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end