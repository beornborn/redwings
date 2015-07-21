require 'rest-client'
require 'addressable/uri'

module Service::Trello

  TRELLO_USER_NAME = 'redwingsruby'
  TRELLO_ORGANIZATION_NAME = 'rubyredwings'

  def self.boards_backup
    all_boards.each do |board|
      board_backup = TrelloBackup.new(board: board[:name],
                                      data:  get_board_json(board[:id]))
      board_backup.save!
    end
  end

  def self.get_board_json(id)
    endpoint = "https://api.trello.com/1/boards/#{id}"

    uri = Addressable::URI.parse(endpoint)

    uri.query_values = {
      :actions => :all,
      :actions_limit => 1000,
      :cards => :all,
      :lists => :all,
      :members => :all,
      :member_fields => :all,
      :checklists => :all,
      :fields => :all,
      :card_attachments => true,
      :key => '32000478b8ee948f67b044b476ea1df0',
      :token => '1ac9b0de81eaa3f58c2c21bd211429786a341f4a0d1aaa0f906d1492dc6a4e34'
    }

    response = RestClient.get(uri.to_s)

    json = response.body
  end

  def self.all_boards
    endpoint = "https://api.trello.com/1/members/#{TRELLO_USER_NAME}/boards"

    uri = Addressable::URI.parse(endpoint)

    uri.query_values = {
      :fields => 'name',
      :key => '32000478b8ee948f67b044b476ea1df0',
      :token => '1ac9b0de81eaa3f58c2c21bd211429786a341f4a0d1aaa0f906d1492dc6a4e34'
    }

    response = RestClient.get(uri.to_s)

    json = JSON.parse(response.body, symbolize_names: true)

    boards_ids = json.collect { |board| { name: board[:name], id: board[:id] } }
  end

  def self.all_organizations
    endpoint = "https://api.trello.com/1/members/#{TRELLO_USER_NAME}/organizations"

    uri = Addressable::URI.parse(endpoint)

    uri.query_values = {
      :fields => 'name',
      :key => '32000478b8ee948f67b044b476ea1df0',
      :token => '1ac9b0de81eaa3f58c2c21bd211429786a341f4a0d1aaa0f906d1492dc6a4e34'
    }

    response = RestClient.get(uri.to_s)

    json = JSON.parse(response.body, symbolize_names: true)

    organization_ids = json.collect { |organization| { name: organization[:name], id: organization[:id] } }
  end

  def self.add_user_to_organization
    all_organizations.each do |organization|

      # https://trello.com/1/authorize?key=32000478b8ee948f67b044b476ea1df0&response_type=token&expiration=never

      token_uri = Addressable::URI.parse("https://trello.com/1/authorize")

      token_uri.query_values = {
        response_type: 'token',
        expiration:    'never',
        key:           '32000478b8ee948f67b044b476ea1df0',
      }

      token = RestClient.get token_uri


      id = organization[:id]

      endpoint = "https://api.trello.com/1/organizations/#{id}/members"

      uri = Addressable::URI.parse(endpoint)

      query_values = {
        email:    "paliukh.mykhailo@gmail.com",
        fullName: "Mykhailo Paliukh",
        key:      "32000478b8ee948f67b044b476ea1df0",
        token:    "0aee69e0df6aff5419778642449032532534d3ce8a260264c29deff702bb980f"
      }

      RestClient.put uri.to_s, query_values
    end
  end

end

