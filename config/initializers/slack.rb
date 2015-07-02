require "slack"

Slack.configure do |config|
  config.token = "xoxp-4553037629-4553037631-7069230518-6c08d9"
end

Slack.auth_test

