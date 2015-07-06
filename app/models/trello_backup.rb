class TrelloBackup < ActiveRecord::Base
  validates :board, presence: true
  validates :data, presence: true
end
