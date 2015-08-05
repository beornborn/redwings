class Service::TrellosController < ApplicationController
  def sync
  	if Rails.env.production?
      Service::Trello.sync
      redirect_to root_path
    else
      redirect_to root_path, flash: { danger: "You can't do this from local machine!" }
    end
  end
end

