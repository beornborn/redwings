class SlackController < ApplicationController

  def users
    slack_users = User.slack_users

    slack_users.map do |slack_user|
      unless User.where(email: slack_user['email']).exists?
        User.create slack_user.merge(password: 'redwings', password_confirmation: 'redwings')
      end
    end

    redirect_to root_path
  end

end

