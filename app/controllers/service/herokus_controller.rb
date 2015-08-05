require 'rake'

class Service::HerokusController < ApplicationController
  def sync
    %x(bundle exec rake db:sync)
    redirect_to root_path, flash: { success: 'Local database successfully updates!' }
  end
end

