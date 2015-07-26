module Service::TrelloApi

  class Organization

    def self.add_user(email, options)

      query_values = {
        email: email,
        fullName: options[:fullName],
        key: TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      Member.organizations(options[:username]).each do |organization|
        organization_id = organization[:id]

        uri = Addressable::URI.parse "https://api.trello.com/1/organizations/#{organization_id}/members"

        RestClient.put uri.to_s, query_values
      end

    end

  end

end

