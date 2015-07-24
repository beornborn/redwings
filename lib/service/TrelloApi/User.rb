require 'rest-client'
require 'addressable/uri'

module TrelloApi

  class User

    def self.add_to_organizations(user)
      fullName = user[:first_name].to_s + ' ' + user[:last_name].to_s

      query_values = {
        email: user[:email],
        fullName: fullName,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      Organization.all.each do |organization|
        id = organization[:id]

        uri = Addressable::URI.parse "https://api.trello.com/1/organizations/#{id}/members"

        RestClient.put uri.to_s, query_values
      end
    end

    def self.add_to_board(board_name, user)
      fullName = user[:first_name].to_s + ' ' + user[:last_name].to_s

      id = Board.board_id_by_name board_name

      query_values = {
        email: user[:email],
        fullName: fullName,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      uri = Addressable::URI.parse "https://api.trello.com/1/boards/#{id}/members"

      RestClient.put uri.to_s, query_values
    end

    def self.add_basic_tasks(user)
      uri = Addressable::URI.parse "https://api.trello.com/1/lists"

      query_values = {
        name: user[:username],
        idBoard:      Board.board_id_by_name(TRELLO_BOARD_PROCESS_NAME),
        idListSource: List.list_id_by_names(TRELLO_LIST_TASKS_NAME, TRELLO_BOARD_KNOWLEDGE_NAME),
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      RestClient.post uri.to_s, query_values
    end

  end

end

