module Service::TrelloApi
  class Card
    def self.checklists(checklist_id)
      uri = Addressable::URI.parse(API_PATH + "/cards/#{checklist_id}/checklists")

      uri.query_values = {
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {:id=>"550ea068065941262cb8433e", :name=>"Linux: 11h", ..
      JSON.parse response.body, symbolize_names: true
    end
  end
end
