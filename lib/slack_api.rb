module SlackApi

  def self.get_members
    data = Slack.get('https://ruby-redwings.slack.com/api/users.list')
    data['members']
  end

end

