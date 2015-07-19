class TrelloBackupsController < ApplicationController

  def index
    @trello_backups = TrelloBackup.all.order(created_at: :desc)
  end

  def create
    Service::Trello.boards_backup

    flash[:success] = 'Backup successful!'

    redirect_to trello_backups_path
  end

  def destroy
    @trello_backup = TrelloBackup.find(params[:id])

    @trello_backup.destroy

    flash[:success] = 'Backup was successfully destroyed.'
    redirect_to trello_backups_path
  end
end
