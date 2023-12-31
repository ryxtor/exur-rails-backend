class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :gender)
  end
end
