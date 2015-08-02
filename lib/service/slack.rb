module Service
  module Slack
  	def self.sync
  	  slack_users = SlackApi::User.all

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
  end
end

