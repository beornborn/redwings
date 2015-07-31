module Service::TrelloApi
  class Member
    def self.organizations(username)
      uri = Addressable::URI.parse(API_PATH + "/members/#{username}/organizations")

      uri.query_values = {
        fields: :all,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {:id=>"5535f60166cc319822e324ad", :name=>"rubyredwings", :displayName=>"RUBY", :desc=>"", :descData=>{:emoji=>{}}, :idBoards=>["5535f4953c9df00305ec756a",..
      JSON.parse response.body, symbolize_names: true
    end

    def self.boards(username)
      uri = Addressable::URI.parse(API_PATH + "/members/#{username}/boards")

      uri.query_values = {
        fields: :all,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      response = RestClient.get uri.to_s

      # {:name=>"KNOWLEDGE", :id=>"5535f4953c9df00305ec756a"}
      JSON.parse response.body, symbolize_names: true
    end
  end
end

