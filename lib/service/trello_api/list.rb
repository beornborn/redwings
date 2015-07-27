module Service::TrelloApi

  class List

    def self.add_list_to_board(new_list_name, board_id, list_source_id)
      uri = Addressable::URI.parse(API_PATH + "/lists")

      query_values = {
        name:    new_list_name,
        idBoard: board_id,
        idListSource: list_source_id,
        key:   TRELLO_APP_KEY,
        token: TRELLO_APP_TOKEN
      }

      RestClient.post uri.to_s, query_values
    end

  end

end

