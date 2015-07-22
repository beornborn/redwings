require 'rest-client'
require 'addressable/uri'

module Service::Trello

  TRELLO_USER_NAME          = 'redwingsruby'
  TRELLO_LIST_TASKS_ID      = '550f1cbb3de6f9ff0bb9bc70'
  TRELLO_BOARD_KNOWLEDGE_ID = '5535f4953c9df00305ec756a'
  TRELLO_BOARD_PROCESS_ID   = '5509f16ba6a4e2b5e43dacea'


  def self.boards_backup
    all_boards.each do |board|
      board_backup = TrelloBackup.new(board: board[:name], data: get_board_json(board[:id]))
      board_backup.save!
    end
  end


  def self.get_board_json(id)
    endpoint = "https://api.trello.com/1/boards/#{id}"

    uri = Addressable::URI.parse endpoint

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
      key:    '7ffc02586ffbf8d0779021dcf8ec9b51',
      token:  'f9c21895fc86b109a0050c2b37fcb61b75a1e777a3f712f6335d6393e0cb3772'
    }

    response = RestClient.get uri.to_s

    json = response.body
  end


  def self.all_boards
    endpoint = "https://api.trello.com/1/members/#{TRELLO_USER_NAME}/boards"

    uri = Addressable::URI.parse endpoint

    uri.query_values = {
      fields: 'name',
      key:    '7ffc02586ffbf8d0779021dcf8ec9b51',
      token:  'f9c21895fc86b109a0050c2b37fcb61b75a1e777a3f712f6335d6393e0cb3772'
    }

    response = RestClient.get uri.to_s

    json = JSON.parse(response.body, symbolize_names: true)

    boards_ids = json.collect { |board| { name: board[:name], id: board[:id] } }
  end


  def self.all_organizations
    endpoint = "https://api.trello.com/1/members/#{TRELLO_USER_NAME}/organizations"

    uri = Addressable::URI.parse(endpoint)

    uri.query_values = {
      fields: 'name',
      key:    '7ffc02586ffbf8d0779021dcf8ec9b51',
      token:  'f9c21895fc86b109a0050c2b37fcb61b75a1e777a3f712f6335d6393e0cb3772'
    }

    response = RestClient.get uri.to_s

    json = JSON.parse(response.body, symbolize_names: true)

    organization_ids = json.collect { |organization| { name: organization[:name], id: organization[:id] } }
  end


  def self.setup_new_trello_user(user)
    fullName = user[:first_name].to_s + user[:last_name].to_s

    query_values = {
      email:    user[:email],
      fullName: fullName,
      key:      '7ffc02586ffbf8d0779021dcf8ec9b51',
      token:    'f9c21895fc86b109a0050c2b37fcb61b75a1e777a3f712f6335d6393e0cb3772'
    }

    # add user to organizations
    all_organizations.each do |organization|
      id = organization[:id]

      endpoint = "https://api.trello.com/1/organizations/#{id}/members"

      uri = Addressable::URI.parse endpoint

      RestClient.put uri.to_s, query_values
    end

    # add user to boards KNOWLEDGE and PROCESS
    all_boards.each do |board|
      name = board[:name]

      if (name == 'KNOWLEDGE') || (name == 'PROCESS')
        id = board[:id]

        endpoint = "https://api.trello.com/1/boards/#{id}/members"

        uri = Addressable::URI.parse endpoint

        RestClient.put uri.to_s, query_values
      end
    end

    # copy tasks cards from KNOWLEDGE to PROCESS with username name of list
    endpoint = "https://api.trello.com/1/lists"

    uri = Addressable::URI.parse endpoint

    query_values = {
      name: user[:username],
      idBoard:      TRELLO_BOARD_PROCESS_ID,
      idListSource: TRELLO_LIST_TASKS_ID,
      key:   '7ffc02586ffbf8d0779021dcf8ec9b51',
      token: 'f9c21895fc86b109a0050c2b37fcb61b75a1e777a3f712f6335d6393e0cb3772'
    }

    RestClient.post uri.to_s, query_values
  end


end

