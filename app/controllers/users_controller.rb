class UsersController < ApplicationController

  def index
    @users = User.admin(false).deleted(false)
    @users_deleted = User.admin(false).deleted(true)
  end

  def sync
    slack_users = User.slack_users

    slack_users.each do |slack_user|
      if User.is_new?(slack_user["email"])
        username = slack_user["username"]
      	deleted = slack_user["deleted"]
      	first_name = slack_user["first_name"]
      	last_name = slack_user["last_name"]
      	image_48 = slack_user["image_48"]
      	email = slack_user["email"]
      	User.create(username: username,
      		        first_name: first_name,
      		        last_name: last_name,
      		        email: email,
      		        deleted: deleted,
      		        image_48: image_48,
      		        password: "1111",
      		        password_confirmation: "1111")
      end
    end
    redirect_to :users
  end

end

