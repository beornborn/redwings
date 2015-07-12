class UsersController < ApplicationController

  attr_accessor :goodbye_reason

  def index
    @users = User.admin(false).deleted(false)
    @users_deleted = User.admin(false).deleted(true)
  end

  def update
    user = User.find(params[:id])
    user.attributes = user_params
    user.save validate: false
  end

  private

  def user_params
    params.require(:user).permit(:goodbye_reason)
  end

end

