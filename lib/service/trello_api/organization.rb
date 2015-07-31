module Service::TrelloApi
  class Organization
    def self.members(organization_id)
      uri = Addressable::URI.parse(API_PATH + "/organizations/#{organization_id}/members")

      uri.query_values = {
        fields: :all,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {:id=>"557803058eaa35a2faa2ef35", :fullName=>"Andrey Matvienko", :initials=>"AM", :memberType=>"normal", :username=>"andrey_matvienko"}
      JSON.parse response.body, symbolize_names: true
    end

    def self.add_user(email, fullName, organization_id)
      uri = Addressable::URI.parse(API_PATH + "/organizations/#{organization_id}/members")

      query_values = {
        email:    email,
        fullName: fullName,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      RestClient.put uri.to_s, query_values
    end

    def self.delete_user(organization_id, member_id)
      uri = Addressable::URI.parse(API_PATH + "/organizations/#{organization_id}/members/#{member_id}")

      query_values = {
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      # it's for data protection, not all users changed their usernames
      # RestClient.delete uri.to_s, query_values
    end
  end
end

