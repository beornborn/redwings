module Service::SlackApi
  class User
    def self.all
      Slack.get(API_PATH + '/users.list')
    end
  end
end

