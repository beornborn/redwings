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
    respond_to do |format|
      if user.save
        format.json { render :json => { :goodbye_reason => user.goodbye_reason } }
      else
        format.json { render :json => user.errors }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:goodbye_reason)
  end

end

