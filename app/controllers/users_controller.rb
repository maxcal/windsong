class UsersController < ApplicationController
  before_filter :set_user, only: [:show]

  respond_to :json

  # @example
  #   GET /users/:id
  # @param id [String] id or slug of user
  def show
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
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end