class UsersController < ApplicationController
  before_filter :set_user, only: [:show]

  respond_to :json

  # get /show/:id
  def show
  end

  # get /users
  def index
    @users = User.all
  end

  # User profile page
  # get /users/me
  def me
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end