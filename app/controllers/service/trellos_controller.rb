class Service::TrellosController < ApplicationController
  def sync
    if Rails.env.production?
      Service::Trello.sync
    else
      flash[:info] = "You can't do this from local machine!"
    end

    redirect_to root_path
  end
end

