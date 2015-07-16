module Service::Trello
  BOARDS = { 'KNOWLEDGE' => 'Y1hS3CKr', 'PROCESS' => 'bRBjLqcF' }

  def self.boards_backup (boards)
    backup_results = {}

    boards.each do |key, value|
      trello_board = Trello::Board.find(value)

      board_backup = TrelloBackup.new(
                      board: trello_board.name,
                      data: get_board_json(trello_board.id,
                                           trello_board.url,
                                           trello_board.name))

      result = board_backup.save

      backup_results.merge!(board_backup.board => result)
    end

    backup_results
  end

  def self.get_board_json(id, url, name)
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
