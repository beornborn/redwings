module Service::Trello
  BOARDS = Trello::Board.all

  def self.boards_backup
    backup_results = {}

    BOARDS.each do |board|
      board_backup = TrelloBackup.new(name: board.name,
                                      data: get_board_json(board.id))

      result = board_backup.save

      backup_results.merge!(board_backup.name => result)
    end

    backup_results
  end

  def self.get_board_json(id)
    endpoint = "https://api.trello.com/1/boards/#{id}"

    uri = Addressable::URI.parse(endpoint)

    uri.query_values = {
      :actions => :all,
      :actions_limit => 1000,
      :cards => :all,
      :lists => :all,
      :members => :all,
      :member_fields => :all,
      :checklists => :all,
      :fields => :all,
      :card_attachments => true,
      :key => '32000478b8ee948f67b044b476ea1df0',
      :token => '1ac9b0de81eaa3f58c2c21bd211429786a341f4a0d1aaa0f906d1492dc6a4e34'
    }

    response = RestClient.get(uri.to_s)

    json = response.body
  end
end
