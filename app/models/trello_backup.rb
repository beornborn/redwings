class TrelloBackup < ActiveRecord::Base
  validates :board, :data, presence: true
end
