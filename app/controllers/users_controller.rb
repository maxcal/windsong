class UsersController < ApplicationController
  before_filter :set_user, only: [:show]

  # get /show/:id
  def show
  end

  # get /users
  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end