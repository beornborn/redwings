module Service

  module Trello

    USER_NAME = 'redwingsruby'
    LIST_TASKS = 'tasks'
    BOARD_PROCESS  = 'PROCESS'
    BOARD_KNOWLEDGE = 'KNOWLEDGE'

    def self.boards_backup
      TrelloApi::Board.all(USER_NAME).each do |board|
        board_backup = TrelloBackup.create!(board: board[:name], data: TrelloApi::Board.data(board[:id]))
      end
    end

    def self.setup_user(user)

      email = user[:email]
      fullName = user[:first_name].to_s + ' ' + user[:last_name].to_s

      # add user to organization
      options = {
        username: USER_NAME,
        fullName: fullName,
      }

      TrelloApi::Organization.add_user(email, options)


      # add user to board KNOWLEDGE
      board = board_by_name(BOARD_KNOWLEDGE)
      idBoard = board[:id]

      options = {
        idBoard: idBoard,
        fullName: fullName
      }

      TrelloApi::Board.add_user(email, options)


      # add user to board PROCESS
      board = board_by_name(BOARD_PROCESS)
      idBoard = board[:id]

      options = {
        idBoard: idBoard,
        fullName: fullName
      }

      TrelloApi::Board.add_user(email, options)


      # set basic tasks for user
      board = board_by_name(BOARD_PROCESS)
      idBoard = board[:id]

      list = list_by_names(LIST_TASKS, BOARD_KNOWLEDGE)
      idListSource = list['id']

      options = {
        name: user[:username],
        idBoard: idBoard,
        idListSource: idListSource
      }

      TrelloApi::List.add_list_to_board options
    end

    private

    def self.board_by_name(board_name)
      TrelloApi::Board.all(USER_NAME).each do |board|
        return board if board[:name] == board_name
      end
    end

    def self.list_by_names(list_name, board_name)
      board = board_by_name board_name
      board_id = board[:id]

      lists = TrelloApi::Board.lists board_id

      lists.each do |list|
        return list if list['name'] == list_name
      end
    end

  end

end

