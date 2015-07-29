module Service::TrelloApi
  class Organization
    def self.add_user(email, fullName, organization_id)
      uri = Addressable::URI.parse(API_PATH + "/organizations/#{organization_id}/members")

      uri.query_values = {
        email:    email,
        fullName: fullName,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      RestClient.put uri.to_s, query_values
    end
  end
end

