class Service::HerokusController < ApplicationController
  def sync
    Database.sync
    redirect_to root_path, flash: { success: 'Local database successfully updated!' }
  end
end
