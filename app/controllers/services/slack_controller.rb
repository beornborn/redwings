class Services::SlackController < ApplicationController

  def users
    slack_users = User.slack_users

    slack_users.map do |slack_user|
      user = User.where(email: slack_user['email'])

      unless user.exists?
        User.create slack_user.merge(password: 'redwings', password_confirmation: 'redwings')
      else
      	user.update_all(slack_user)
      end

    end

    redirect_to root_path
  end

end

