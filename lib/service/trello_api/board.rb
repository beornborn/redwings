module Service::TrelloApi
  class Board
    def self.data(board_id)
      uri = Addressable::URI.parse(API_PATH + "/boards/#{board_id}")

      uri.query_values = {
        cards:         :all,
        lists:         :all,
        fields:        :all,
        members:       :all,
        actions:       :all,
        checklists:    :all,
        member_fields: :all,
        actions_limit: 1000,
        card_attachments: true,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {:id=>"55b2621d76834b6aa079134e", :name=>"KNOWLEDGE-2015-07-24 11:49:38 +0300", ..
      JSON.parse response.body, symbolize_names: true
    end

    def self.lists(board_id)
      uri = Addressable::URI.parse(API_PATH + "/boards/#{board_id}/lists")

      uri.query_values = {
        cards: :open,
        lists: :open,
        fields: :all,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {:id=>"553568193dabb8b4a9fccf72", :name=>"workflow", ..
      JSON.parse response.body, symbolize_names: true
    end

    def self.add_user(email, full_name, board_id)
      uri = Addressable::URI.parse(API_PATH + "/boards/#{board_id}/members")

      uri.query_values = {
        email:    email,
        fullName: full_name,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      RestClient.put uri.to_s, uri.query_values
    end
  end
end

