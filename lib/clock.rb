require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

Clockwork.every(3.hour, 'Users updating from Slack...') do
  User.update_users
end

