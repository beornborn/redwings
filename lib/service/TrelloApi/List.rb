require 'rest-client'
require 'addressable/uri'

module TrelloApi

  class List

    def self.list_id_by_names(list_name, board_name)
      lists = Board.lists board_name

      lists.each do |list|
        return list['id'] if list['name'] == list_name
      end
    end

  end

end

