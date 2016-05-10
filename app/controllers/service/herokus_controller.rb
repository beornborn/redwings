class Service::HerokusController < ApplicationController
  before_filter :forbid_if_guest, only: :sync

  def sync
    Database.sync
    redirect_to root_path, flash: { success: 'Local database successfully updated!' }
  end
end

