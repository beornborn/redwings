class TrelloBackupsController < ApplicationController

  def index
    @trello_backups = TrelloBackup.all

    boards_names = []

    (Service::Trello::BOARDS).each { |key, value| boards_names << key }

    @boards_to_backup = boards_names.join(", ")
  end

  def create
    backup_results = Service::Trello.boards_backup(Service::Trello::BOARDS)

    backup_results.each do |key, value|
      if value == true
        flash[:success] ||= ''
        flash[:success] << "#{key}'s backup succeed. "
      else
        flash[:danger]  ||= ''
        flash[:danger] << "#{key}'s backup failed. "
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
