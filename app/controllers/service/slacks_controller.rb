class Service::SlacksController < ApplicationController
  def sync
  	if Rails.env.production?
  	  Service::Slack.sync
  	  redirect_to root_path
  	else
  	  redirect_to root_path, flash: { danger: "You can't do this from local machine!" }
  	end
  end
end

