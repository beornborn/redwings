module Service
  module Trello

    API_PATH = 'https://api.trello.com/1'
    USER_NAME = 'redwingsruby'
    LIST_TASKS = 'tasks'
    BOARD_PROCESS  = 'PROCESS'
    BOARD_KNOWLEDGE = 'KNOWLEDGE'

    def self.boards_backup
      TrelloApi::Member.boards(USER_NAME).each do |board|
        board_backup = TrelloBackup.create!(board: board[:name], data: TrelloApi::Board.data(board[:id]))
      end
    end


    def self.setup_user(user)
      email = user[:email]
      full_name = user[:first_name] + ' ' + user[:last_name]
      new_list_name = user[:username]

      if full_name.empty?
        full_name = 'Noname'
        new_list_name = 'Noname'
      end

      # add user to organization
      TrelloApi::Member.organizations(USER_NAME).each do |organization|
        organization_id = organization[:id]

        puts organization

        puts organization_id

        #TrelloApi::Organization.add_user(email, full_name, organization_id)
      end

      # add user to board KNOWLEDGE
      board    = board_by_name(BOARD_KNOWLEDGE)
      board_id = board[:id]

      #TrelloApi::Board.add_user(email, full_name, board_id)

      # add user to board PROCESS
      board    = board_by_name(BOARD_PROCESS)
      board_id = board[:id]

      #TrelloApi::Board.add_user(email, full_name, board_id)

      # set basic tasks for user
      board    = board_by_name(BOARD_PROCESS)
      board_id = board[:id]

      list = list_by_names(LIST_TASKS, BOARD_KNOWLEDGE)
      list_source_id = list[:id]

      #TrelloApi::List.add_list_to_board(new_list_name, board_id, list_source_id)
    end

    private

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

