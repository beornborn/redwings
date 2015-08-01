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
      trello_users = []

      TrelloApi::Organization.members(organization[:id]).each do |trello_user|
        trello_users.push({ id: trello_user[:id], username: trello_user[:username]})
      end

      # it's for testing
      puts trello_users

      # get local active users
      db_users_active = User.deleted(false)

      # cleanup users
      trello_users.map do |trello_user|
        unless trello_user[:username] == USER_NAME
          username = convert_to_slack_username trello_user[:username]

          # show users, that would be deleted
          unless user_exist?(username, db_users_active)
            puts "cleanup: #{trello_user[:username]}"
          end

          unless user_exist?(username, db_users_active)
          # TrelloApi::Organization.delete_user(organization[:id], trello_user[:id])

            list = list_by_names(trello_user[:username], BOARD_PROCESS)
          # TrelloApi::List.close(list[:id]) unless list[:id].nil?
          end
        end
      end

      # setup users
      db_users_active.map do |db_user|
        db_user[:username] = 'redwings_' + db_user[:first_name].downcase + '_' + db_user[:last_name].downcase

        # show users, that would be setuped
        unless user_exist?(db_user[:username], trello_users)
          puts "setup: #{db_user[:username]}"
        end

        setup_user(db_user) unless user_exist?(db_user[:username], trello_users)
      end
    end

    def self.setup_user(user)
      email = user.email
      full_name = user.first_name + ' ' + user.last_name

      # add user to organization
      organization = organization_by_name ORGANIZATION_NAME
      # TrelloApi::Organization.add_user(email, full_name, organization[:id])

      # set basic tasks for user
      new_list_name = 'redwings_' + user.first_name.downcase + ' ' + user.last_name.downcase

      board_process = board_by_name BOARD_PROCESS
      list_source   = list_by_names(LIST_TASKS, BOARD_KNOWLEDGE)

      # TrelloApi::List.add_list_to_board(new_list_name, board_process[:id], list_source[:id])
    end

    private

    def self.user_exist?(username, list)
      return true if list.find { |user| user[:username] == username }
    end

    def self.convert_to_slack_username(username)
      username = username.gsub(/redwings_/, '')
      username.gsub(/_/, '.')
    end

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
