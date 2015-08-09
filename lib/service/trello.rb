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
      cleanup_users
      cleanup_academy_tasks
      setup_users
      setup_academy_tasks
      update_academy_tasks_time
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
      active_academy_users = Project.find_by(name: 'Academy').users.disabled

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
        username = convert_to_trello_username db_user.username

        unless trello_users.any? { |trello_user| trello_user[:username] == username }
          email     = db_user.email
          full_name = db_user.first_name + ' ' + db_user.last_name
          TrelloApi::Organization.add_user(email, full_name, organization[:id])
        end
      end
    end

    def self.setup_academy_tasks
      board_process = board_by_name BOARD_PROCESS
      process_lists = TrelloApi::Board.lists board_process[:id]

      Project.find_by(name: 'Academy').users.disabled.each do |db_user|
        username = convert_to_trello_username db_user.username

        unless process_lists.any? { |list| list[:name] == username }
          new_list_name = convert_to_trello_username db_user.username
          list_source   = list_in_board(LIST_TASKS, BOARD_KNOWLEDGE)
          TrelloApi::List.add_list_to_board(new_list_name, board_process[:id], list_source[:id])
        end
      end
    end

    def self.update_academy_tasks_time
      knowledge_list = list_in_board(LIST_TASKS, BOARD_KNOWLEDGE)

      @project = Project.find_by(name: "Academy")
      @project.data = { 'total_tasks_time' => total_tasks_time(knowledge_list, 'incomplete'),
                        'time_for_project' => 30 * 24 * 60 * 60 }
      @project.save
    end

    def self.sync_users_spent_time
      board_process = board_by_name BOARD_PROCESS

      TrelloApi::Board.lists(board_process[:id]).each do |list|
        username = convert_to_slack_username list[:name]

        spent_time = total_tasks_time(list, 'complete')

        user = User.where(username: username)
        user.spent_time = spent_time
        user.save

        project = user.projects.find { |project| project[:name] == 'Academy' }
        project.data = { 'spent_time' => spent_time }
        project.save
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

        check_items = checklist[:checkItems]
        check_items.each { |item| check_items_names << item[:name] if item[:state] == state}
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

