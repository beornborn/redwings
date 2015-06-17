class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password)
  end

end
