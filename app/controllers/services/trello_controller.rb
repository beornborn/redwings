class Services::TrelloController < ApplicationController
  def update_users
    User.trello_update_users
    redirect_to root_path
  end
end

