class Services::SlackController < ApplicationController
  def update_users
    User.slack_update_users
    redirect_to root_path
  end
end

