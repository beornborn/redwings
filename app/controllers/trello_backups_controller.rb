class TrelloBackupsController < ApplicationController

  def index
    @trello_backups = TrelloBackup.all

    @boards_to_backup = []

    Service::Trello::BOARDS.each { |board| @boards_to_backup << board.name }
  end

  def create
    backup_results = Service::Trello.boards_backup

    backup_results.each do |name, result|
      if result == true
        flash[:success] ||= ''
        flash[:success] << "#{name}'s backup succeed. "
      else
        flash[:danger]  ||= ''
        flash[:danger] << "#{name}'s backup failed. "
      end
    end

    redirect_to trello_backups_path
  end

  def destroy
    @trello_backup = TrelloBackup.find(params[:id])

    @trello_backup.destroy

    flash[:success] = 'Backup was successfully destroyed.'
    redirect_to trello_backups_path
  end
end
