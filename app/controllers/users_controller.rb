class UsersController < ApplicationController
  require 'json'

  def index
  	@users = User.all
  end

end

