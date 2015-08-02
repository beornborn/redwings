module Service
  module Slack
    def self.sync
      slack_users = users(SlackApi::User.all)

      slack_users.map do |slack_user|
        user = User.find_or_initialize_by(email: slack_user['email'])

        academy_project = Project.find_by(name: 'Academy')

        if user.new_record?
          user = User.create! slack_user.merge(password: 'redwings', password_confirmation: 'redwings', started_at: Time.now)
          user.projects << academy_project
        else
          user.attributes = slack_user
          user.save!
        end
      end
    end

    private

    def self.users(data)
      members = data['members']

      users = members.map do |member|
        user = {}
        user['username'] =   member['name']
        user['first_name'] = member['profile']['first_name']
        user['last_name']  = member['profile']['last_name']
        user['image_48'] =   member['profile']['image_48']
        user['email'] =      member['profile']['email']
        user['deleted'] =    member['deleted']
        user
      end

      users
    end
  end
end

