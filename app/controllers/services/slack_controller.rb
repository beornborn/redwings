class Services::SlackController < ApplicationController

  def users
    User.update_users
    redirect_to root_path
  end

end

