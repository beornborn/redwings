require 'rest-client'
require 'addressable/uri'

module TrelloApi

  class Organization

    def self.all
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

end

