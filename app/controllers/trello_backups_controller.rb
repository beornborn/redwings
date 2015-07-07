class TrelloBackupsController < ApplicationController
  def index
    @trello_backups = TrelloBackup.all
  end

  def create
    boards = Trello::Board.all
    boards.each do |b|
      board_backup = TrelloBackup.new(board: b.name,
                       data: get_board_json(b.id, b.url, b.name))
      board_backup.save
    end
    flash[:success] = 'Backup successful!'
    redirect_to trello_backups_path
  end

  def destroy
    @trello_backup = TrelloBackup.find(params[:id])
    @trello_backup.destroy
    flash[:success] = 'Backup was successfully destroyed.'
    redirect_to trello_backups_path
  end

  private
    def trello_backup_params
      params.require(:trello_backup).permit(:board, :data)
    end

    def get_board_json(id, url, name)
      endpoint = "https://api.trello.com/1/boards/#{id}"
      uri = Addressable::URI.parse(endpoint)
      uri.query_values = {
        :actions => :all,
        :actions_limit => 1000,
        :cards => :all,
        :lists => :all,
        :members => :all,
        :member_fields => :all,
        :checklists => :all,
        :fields => :all,
        :card_attachments => true,
        :key => '32000478b8ee948f67b044b476ea1df0',
        :token => '1ac9b0de81eaa3f58c2c21bd211429786a341f4a0d1aaa0f906d1492dc6a4e34'
      }
      response = RestClient.get(uri.to_s)
      json = response.body
    end
end
