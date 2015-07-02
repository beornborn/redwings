class UsersController < ApplicationController
  require 'json'

  def index
  	@users = User.all
  	#url = "https://ruby-redwings.slack.com/api/users.list?token=xoxp-4553037629-4553037631-7069230518-6c08d9"
  	#@users = JSON.parse(JSON.load(url))
  end

end

