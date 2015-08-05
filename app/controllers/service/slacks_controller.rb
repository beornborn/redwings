class Service::SlacksController < ApplicationController
  def sync
    if Rails.env.production?
      Service::Slack.sync
    else
      flash[:info] = "You can't do this from local machine!"
    end

    redirect_to root_path
  end
end

