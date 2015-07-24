require_relative './TrelloApi/Organization.rb'
require_relative './TrelloApi/Board.rb'
require_relative './TrelloApi/List.rb'
require_relative './TrelloApi/User.rb'

TRELLO_USER_NAME       = 'redwingsruby'
TRELLO_LIST_TASKS_NAME = 'tasks'

TRELLO_BOARD_PROCESS_NAME   = 'PROCESS'
TRELLO_BOARD_KNOWLEDGE_NAME = 'KNOWLEDGE'

module Service

  module Trello

    def self.boards_backup
      TrelloApi::Board.all.each do |board|
        board_backup = TrelloBackup.create!(board: board[:name], data: TrelloApi::Board.data_by_id(board[:id]))
      end
    end

    def self.setup_user(user)
      TrelloApi::User.add_to_organizations user

      TrelloApi::User.add_to_board TRELLO_BOARD_KNOWLEDGE_NAME, user
      TrelloApi::User.add_to_board TRELLO_BOARD_PROCESS_NAME,   user

      TrelloApi::User.add_basic_tasks user
    end

  end

end

