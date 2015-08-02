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
      # get trello users
      organization = organization_by_name ORGANIZATION_NAME
      trello_users = TrelloApi::Organization.members organization[:id]

      trello_users.delete_if { |user| user[:username] == USER_NAME }

      # get local active users
      db_users_active = User.deleted(false)

      # cleanup users
      cleanup_list = []

      trello_users.select do |trello_user|
        username = convert_to_slack_username trello_user[:username]

        unless db_users_active.any? { |db_user| db_user[:username] == username }
          cleanup_list.push trello_user
        end
      end

      cleanup(cleanup_list)

      # setup users
      setup_list = []

      db_users_active.select do |db_user|
        username = convert_to_trello_username db_user[:username]

        unless trello_users.any? { |trello_user| trello_user[:username] == username }
          setup_list.push db_user
        end
      end

      setup(setup_list)
    end

    def self.cleanup(users)
      users.select do |user|
        puts "cleanup: #{user[:username]}"
        # TrelloApi::Organization.delete_user(organization[:id], user[:id])

        list = list_in_board(user[:username], BOARD_PROCESS)
        # TrelloApi::List.close(list[:id]) unless list[:id].nil?
      end
    end

    def self.setup(users)
      organization = organization_by_name ORGANIZATION_NAME

      users.select do |user|
        email = user.email
        full_name = user.first_name + ' ' + user.last_name

        # add user to organization
        # TrelloApi::Organization.add_user(email, full_name, organization[:id])

        # set basic tasks for user
        new_list_name = convert_to_trello_username user.username
        board_process = board_by_name BOARD_PROCESS
        list_source   = list_in_board(LIST_TASKS, BOARD_KNOWLEDGE)

        # TrelloApi::List.add_list_to_board(new_list_name, board_process[:id], list_source[:id])
        puts "setup: #{new_list_name}"
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

