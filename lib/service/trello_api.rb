require 'rest-client'
require 'addressable/uri'

module Service::TrelloApi
  API_PATH          = 'https://api.trello.com/1'
  USER_NAME         = 'redwingsruby'
  LIST_TASKS        = 'tasks'
  BOARD_PROCESS     = 'PROCESS'
  BOARD_KNOWLEDGE   = 'KNOWLEDGE'
  ORGANIZATION_NAME = 'rubyredwings'
end

