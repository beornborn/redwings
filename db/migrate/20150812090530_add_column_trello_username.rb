class AddColumnTrelloUsername < ActiveRecord::Migration
  def change
    add_column :users, :trello_username, :string
  end
end

