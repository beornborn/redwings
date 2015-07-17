class FixBoard < ActiveRecord::Migration
  def change
    rename_column :trello_backups, :board, :name
  end
end
