require 'rest-client'
require 'addressable/uri'

include TrelloAPI

module Service::Trello

  def self.boards_backup
    TrelloAPI::Board.all_boards.each do |board|
      board_backup = TrelloBackup.new(board: board[:name], data: TrelloAPI::Board.board_data_by_id(board[:id]))
      board_backup.save!
    end
  end


  def self.setup_trello_user(user)
  	TrelloAPI::User.add_to_organizations user

    TrelloAPI::User.add_to_board TRELLO_BOARD_KNOWLEDGE_NAME, user
    TrelloAPI::User.add_to_board TRELLO_BOARD_PROCESS_NAME,   user

    TrelloAPI::User.add_basic_tasks user
  end

end

