module TrelloAPI

  class Board

    def self.board_data_by_id(id)
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

    def self.all_boards
      uri = Addressable::URI.parse "https://api.trello.com/1/members/#{TRELLO_USER_NAME}/boards"

      uri.query_values = {
        fields: 'name',
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      json = JSON.parse(response.body, symbolize_names: true)

      # {:name=>"KNOWLEDGE", :id=>"5535f4953c9df00305ec756a"}
      # ..
      boards_ids = json.collect { |board| { name: board[:name], id: board[:id] } }
    end

    def self.board_id_by_name(board_name)
      all_boards.each do |board|
      	return board[:id] if board[:name] == board_name
      end
    end

    def self.board_lists(board_name)
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


  class Organization

    def self.all_organizations
      uri = Addressable::URI.parse "https://api.trello.com/1/members/#{TRELLO_USER_NAME}/organizations"

      uri.query_values = {
        fields: 'name',
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      json = JSON.parse(response.body, symbolize_names: true)

      # {:name=>"rubyredwings", :id=>"5535f60166cc319822e324ad"}
      organization_ids = json.collect { |organization| { name: organization[:name], id: organization[:id] } }
    end

  end


  class List

    def self.list_id_by_names(list_name, board_name)
      lists = Board.board_lists board_name

      lists.each do |list|
        return list['id'] if list['name'] == list_name
      end
    end

  end


  class User

    def self.add_to_organizations(user)
      fullName = user[:first_name].to_s + ' ' + user[:last_name].to_s

      query_values = {
        email: user[:email],
        fullName: fullName,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      Organization.all_organizations.each do |organization|
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

