class UsersController < ApplicationController

  def index
    @users = User.admin(false).deleted(false)
    @users_deleted = User.admin(false).deleted(true)
  end

  def sync
  end

end

