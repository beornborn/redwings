class TrelloBackupsController < ApplicationController
  def index
    @trello_backups = TrelloBackup.all
  end

  def create
    @boards = Trello::Board.all
    @boards.each do |b|
      board_backup = TrelloBackup.new(board: b.name,
                       data: get_board_json(b.url, b.name))
      if board_backup.save
        redirect_to trello_backups_path
      else
        render.home
    end
  end

  def destroy
  end

  private
    def trello_backup_params
      params.require(:trello_backup).permit(:board)
    end

    def get_board_json(url, name)
      url_json = url.gsub("/#{name.dowcase}", ".json")
      response = HTTParty.get(url_json)
      JSON.parse(response.body)
    end
end
