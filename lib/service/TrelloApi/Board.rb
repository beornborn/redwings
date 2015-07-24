require 'rest-client'
require 'addressable/uri'

module TrelloApi

  class Board

    def self.data_by_id(id)
      uri = Addressable::URI.parse "https://api.trello.com/1/boards/#{id}"

      uri.query_values = {
        actions:       :all,
        actions_limit: 1000,
        cards:         :all,
        lists:         :all,
        members:       :all,
        member_fields: :all,
        checklists:    :all,
        fields:        :all,
        card_attachments: true,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      json = JSON.parse response.body
    end

    def self.all
      uri = Addressable::URI.parse "https://api.trello.com/1/members/#{TRELLO_USER_NAME}/boards"

      uri.query_values = {
        fields: 'name',
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      json = JSON.parse(response.body, symbolize_names: true)

      # {:name=>"KNOWLEDGE", :id=>"5535f4953c9df00305ec756a"}
      boards_ids = json.collect { |board| { name: board[:name], id: board[:id] } }
    end

    def self.board_id_by_name(board_name)
      all.each do |board|
      	return board[:id] if board[:name] == board_name
      end
    end

    def self.lists(board_name)
      id = board_id_by_name board_name

      uri = Addressable::URI.parse "https://api.trello.com/1/boards/#{id}/lists"

      uri.query_values = {
        cards:  :open,
        lists:  :open,
        fields: :all,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {"id"=>"553568193dabb8b4a9fccf72", "name"=>"workflow", "closed"=>false, "idBoard"=>"5535..
      lists = JSON.parse response.body
    end

  end

end

