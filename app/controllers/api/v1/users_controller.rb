class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find params[:id]
    render json: @user
  end

  def current_user_data
    # get user data using the bearer token
    @user = current_user
    render json: @user
  end
end
