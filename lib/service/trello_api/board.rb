module Service::TrelloApi

  class Board

    def self.data(board_id)
      uri = Addressable::URI.parse "https://api.trello.com/1/boards/#{board_id}"

      uri.query_values = {
        actions: :all,
        actions_limit: 1000,
        cards: :all,
        lists: :all,
        members: :all,
        member_fields: :all,
        checklists: :all,
        fields: :all,
        card_attachments: true,
        key: TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      json = JSON.parse response.body
    end

    def self.all(username)
      uri = Addressable::URI.parse "https://api.trello.com/1/members/#{username}/boards"

      uri.query_values = {
        fields: 'name',
        key: TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      json = JSON.parse(response.body, symbolize_names: true)

      # {:name=>"KNOWLEDGE", :id=>"5535f4953c9df00305ec756a"}
      boards_ids = json.collect { |board| { name: board[:name], id: board[:id] } }
    end

    def self.lists(board_id)
      uri = Addressable::URI.parse "https://api.trello.com/1/boards/#{board_id}/lists"

      uri.query_values = {
        cards: :open,
        lists: :open,
        fields: :all,
        key: TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {"id"=>"553568193dabb8b4a9fccf72", "name"=>"workflow", "closed"=>false, "idBoard"=>"5535..
      lists = JSON.parse response.body
    end

    def self.add_user(email, options)

      query_values = {
        email: email,
        fullName: options[:fullName],
        key: TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      board_id = options[:idBoard]

      uri = Addressable::URI.parse "https://api.trello.com/1/boards/#{board_id}/members"

      RestClient.put uri.to_s, query_values
    end

  end

end

