module Service
  module Trello
    USER_NAME         = 'redwingsruby'
    LIST_TASKS        = 'tasks'
    BOARD_PROCESS     = 'PROCESS'
    BOARD_KNOWLEDGE   = 'KNOWLEDGE'
    ORGANIZATION_NAME = 'rubyredwings'

    def self.boards_backup
      TrelloApi::Member.boards(USER_NAME).each do |board|
        board_backup = TrelloBackup.create!(board: board[:name], data: TrelloApi::Board.data(board[:id]))
      end
    end

    def self.setup_user(user)
      email = user[:email]
      full_name = (user[:first_name] + ' ' + user[:last_name]).presence || 'Noname'

      # add user to organization
      organization = organization_by_name(ORGANIZATION_NAME)
      TrelloApi::Organization.add_user(email, full_name, organization[:id])

      # add user to board KNOWLEDGE
      board_knowledge = board_by_name(BOARD_KNOWLEDGE)
      TrelloApi::Board.add_user(email, full_name, board_knowledge[:id])

      # add user to board PROCESS
      board_process = board_by_name(BOARD_PROCESS)
      TrelloApi::Board.add_user(email, full_name, board_process[:id])

      # set basic tasks for user
      new_list_name = user[:username].presence || 'Noname'

      list_source = list_by_names(LIST_TASKS, BOARD_KNOWLEDGE)

      TrelloApi::List.add_list_to_board(new_list_name, board_process[:id], list_source[:id])
    end

    private

    def self.organization_by_name(organization_name)
      TrelloApi::Member.organizations(USER_NAME).find { |organization| organization[:name] == organization_name }
    end

    def self.board_by_name(board_name)
      TrelloApi::Member.boards(USER_NAME).find { |board| board[:name] == board_name }
    end

    def self.list_by_names(list_name, board_name)
      board = board_by_name board_name
      lists = TrelloApi::Board.lists board[:id]
      lists.find { |list| list[:name] == list_name }
    end
  end
end

