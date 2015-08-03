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

    def self.sync
      cleanup
      setup_users
    end


    def self.cleanup
      # get trello users
      organization = organization_by_name ORGANIZATION_NAME
      trello_users = TrelloApi::Organization.members organization[:id]
      trello_users.delete_if { |user| user[:username] == USER_NAME }

      # get local active users
      db_users_active = User.deleted(false)

      # cleanup disabled users and their lists
      trello_users.each do |trello_user|
        username = convert_to_slack_username trello_user[:username]

        unless db_users_active.any? { |db_user| db_user[:username] == username }
          TrelloApi::Organization.delete_user(organization[:id], trello_user[:id])
          list = list_in_board(trello_user[:username], BOARD_PROCESS)

          if list.present?
            TrelloApi::List.close(list[:id])
          end
        end
      end

      # cleanup lists of users redwings project
      Project.find_by(name: 'Redwings').users.each do |db_user|
        list = list_in_board(convert_to_trello_username(db_user[:username]), BOARD_PROCESS)

        if list.present?
          TrelloApi::List.close(list[:id])
        end
      end
    end

    def self.setup_users
      # get trello users
      organization = organization_by_name ORGANIZATION_NAME
      trello_users = TrelloApi::Organization.members organization[:id]
      trello_users.delete_if { |user| user[:username] == USER_NAME }

      # get local active users
      db_users_active = User.deleted(false)

      # setup users
      board_process = board_by_name BOARD_PROCESS

      db_users_active.each do |db_user|
        username = convert_to_trello_username db_user[:username]

        unless trello_users.any? { |trello_user| trello_user[:username] == username }
          email = db_user.email
          full_name = db_user.first_name + ' ' + db_user.last_name

          # add user to organization
          TrelloApi::Organization.add_user(email, full_name, organization[:id])

          # set basic tasks for user
          new_list_name = convert_to_trello_username db_user.username
          list_source   = list_in_board(LIST_TASKS, BOARD_KNOWLEDGE)

          TrelloApi::List.add_list_to_board(new_list_name, board_process[:id], list_source[:id])
        end
      end
    end

    private

    def self.convert_to_slack_username(username)
      username = username.gsub('redwings_', '').gsub('_', '.')
    end

    def self.convert_to_trello_username(username)
      username = 'redwings_' + username.gsub('.', '_')
    end

    def self.organization_by_name(organization_name)
      TrelloApi::Member.organizations(USER_NAME).find { |organization| organization[:name] == organization_name }
    end

    def self.board_by_name(board_name)
      TrelloApi::Member.boards(USER_NAME).find { |board| board[:name] == board_name }
    end

    def self.list_in_board(list_name, board_name)
      board = board_by_name board_name

      if board.present?
        lists = TrelloApi::Board.lists(board[:id])
        lists.find { |list| list[:name] == list_name }
      end
    end
  end
end

