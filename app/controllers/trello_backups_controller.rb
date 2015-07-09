class TrelloBackupsController < ApplicationController

  def index
    @trello_backups = TrelloBackup.all
  end

  def create
    @backups_count = TrelloBackup.all.count
    Service::Trello.board_backup
    if TrelloBackup.all.count == @backups_count + 2
      flash[:success] = 'Backup successful!'
      redirect_to trello_backups_path
    else
      flash[:danger] = 'Backup failed!'
      redirect_to trello_backups_path
    end
  end

  def destroy
    @trello_backup = TrelloBackup.find(params[:id])
    @trello_backup.destroy
    flash[:success] = 'Backup was successfully destroyed.'
    redirect_to trello_backups_path
  end
end
