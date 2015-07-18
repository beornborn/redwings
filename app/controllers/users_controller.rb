class UsersController < ApplicationController

  before_filter :find_user, only: [:update]

  attr_accessor :skip_password_validation

  def index
    @users = User.admin(false).deleted(false).order(started_at: :desc)
    @users_deleted = User.admin(false).deleted(true).order(started_at: :desc)
  end

  def update
    @user.attributes = user_params
    @user.skip_password_validation = true
    @user.save
    render json: { goodbye_reason: @user.goodbye_reason }
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:goodbye_reason)
  end

end

