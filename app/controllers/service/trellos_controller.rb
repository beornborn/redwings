class Service::TrellosController < ApplicationController
  def sync
    Service::Trello.sync
    redirect_to root_path
  end
end

