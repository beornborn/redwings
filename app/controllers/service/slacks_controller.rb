class Service::SlacksController < ApplicationController
  def sync
    Service::Slack.sync
    redirect_to root_path
  end
end

