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
      update_trello_usernames

      cleanup_users
      cleanup_academy_tasks

      setup_users
      setup_academy_tasks

      update_academy_tasks_total_time
      update_academy_tasks_spent_time
    end

    def self.cleanup_users
      organization = organization_by_name ORGANIZATION_NAME
      db_users_active = User.active

      self.trello_users.each do |trello_user|
        username = convert_to_slack_username trello_user[:username]

        unless db_users_active.any? { |db_user| db_user.username == username }
          TrelloApi::Organization.delete_user(organization[:id], trello_user[:id])
        end
      end
    end

    def self.cleanup_academy_tasks
      board_process = board_by_name BOARD_PROCESS
      active_academy_users = Project.find_by(name: 'Academy').users.active

      TrelloApi::Board.lists(board_process[:id]).each do |list|
        listname = convert_to_slack_username list[:name]

        unless active_academy_users.any? { |db_user| db_user.username == listname }
          TrelloApi::List.close(list[:id])
        end
      end
    end

    def self.setup_users
      organization = organization_by_name ORGANIZATION_NAME
      trello_users = self.trello_users

      User.active.each do |db_user|
<<<<<<< HEAD
        unless trello_users.any? { |trello_user| trello_user[:username] == db_user.trello_username }
=======
        username = convert_to_trello_username db_user.username

        unless trello_users.any? { |trello_user| trello_user[:username] == username }
>>>>>>> develop
          email     = db_user.email
          full_name = db_user.first_name + ' ' + db_user.last_name
          TrelloApi::Organization.add_user(email, full_name, organization[:id])
        end
      end
    end

    def self.setup_academy_tasks
      board_process = board_by_name BOARD_PROCESS
      process_lists = TrelloApi::Board.lists board_process[:id]

      Project.find_by(name: 'Academy').users.active.each do |db_user|
<<<<<<< HEAD
        unless process_lists.any? { |list| list[:name] == db_user.trello_username }
=======
        username = convert_to_trello_username db_user.username

        unless process_lists.any? { |list| list[:name] == username }
          new_list_name = convert_to_trello_username db_user.username
>>>>>>> develop
          list_source   = list_in_board(LIST_TASKS, BOARD_KNOWLEDGE)
          TrelloApi::List.add_list_to_board(db_user.trello_username, board_process[:id], list_source[:id])
        end
      end
    end

    def self.update_academy_tasks_total_time
      knowledge_list = list_in_board(LIST_TASKS, BOARD_KNOWLEDGE)

      project = Project.find_by(name: "Academy")
      project.data['total_tasks_time'] = total_tasks_time(knowledge_list, 'incomplete')
      project.data['time_for_project'] = 30 * 24 * 60 * 60
      project.save
    end

    def self.update_academy_tasks_spent_time
      board_process = board_by_name BOARD_PROCESS
      project_id = Project.find_by(name: 'Academy').id

      TrelloApi::Board.lists(board_process[:id]).each do |list|
        projects_user = ProjectsUser.find_by(project_id: project_id)
        projects_user.data['spent_time'] = total_tasks_time(list, 'complete')
        projects_user.save
      end
    end

    def self.update_trello_usernames
      User.active.each do |user|
        user.trello_username = convert_to_trello_username user.username
        user.save
      end
    end

    private

    def self.trello_users
      organization = organization_by_name ORGANIZATION_NAME
      TrelloApi::Organization.members(organization[:id]).delete_if { |user| user[:username] == USER_NAME }
    end

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
      lists = TrelloApi::Board.lists(board[:id]) if board.present?
      lists.find { |list| list[:name] == list_name }
    end

    def self.total_tasks_time(list, state)
      cards = list[:cards]

      check_items_names = []

      cards.each do |card|
        checklist = Service::TrelloApi::Card.checklists(card[:id]).first

        fail('There are no checklist with time in the card') if checklist.nil?

        check_items = checklist[:checkItems].select { |item| item[:state] == state }
        check_items_names.push check_items
      end

      count_time(check_items_names)
    end

    def self.count_time(check_items_names)
      time_string = check_items_names.to_s.scan(/\d{1,2}[hm]{1}/)

      total_time = 0

      time_string.each do |time|
        hours_or_minutes = time.scan(/[hm]{1}/).first

        total_time += time.to_i * 60 if hours_or_minutes == 'm'
        total_time += time.to_i * 60 * 60 if hours_or_minutes == 'h'
      end

      total_time
    end
  end
end

