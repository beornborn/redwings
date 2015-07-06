class TrelloBackupsController < ApplicationController
  def index
    @trello_backups = TrelloBackup.all
  end

  def create

  end

  def destroy
  end

  private

end
