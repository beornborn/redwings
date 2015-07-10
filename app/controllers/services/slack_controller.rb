class Services::SlackController < ApplicationController

  def update_users
    User.update_users
    redirect_to root_path
  end

end

