module SlackApi

  def self.get_users
    data = Slack.get('https://ruby-redwings.slack.com/api/users.list')
    members = data['members']

    users = members.map do |member|
      user = {}
      user['username'] =   member['name']
      user['first_name'] = member['profile']['first_name']
      user['last_name']  = member['profile']['last_name']
      user['image_48'] =   member['profile']['image_48']
      user['email'] =      member['profile']['email']
      user['deleted'] =    member['deleted']
    end

    users
  end

end

