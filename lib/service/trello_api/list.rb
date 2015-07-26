module Service::TrelloApi

  class List

    def self.add_list_to_board(options)
      uri = Addressable::URI.parse "https://api.trello.com/1/lists"

      query_values = {
        name: options[:name],
        idBoard: options[:idBoard],
        idListSource: options[:idListSource],
        key: TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      RestClient.post uri.to_s, query_values
    end

  end

end

