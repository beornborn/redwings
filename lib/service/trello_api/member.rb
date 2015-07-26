module Service::TrelloApi

  class Member

    def self.organizations(username)
      uri = Addressable::URI.parse "https://api.trello.com/1/members/#{username}/organizations"

      uri.query_values = {
        fields: 'name',
        key: TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      json = JSON.parse(response.body, symbolize_names: true)

      # {:name=>"rubyredwings", :id=>"5535f60166cc319822e324ad"}
      organization_ids = json.collect { |organization| { name: organization[:name], id: organization[:id] } }
    end

  end

end

