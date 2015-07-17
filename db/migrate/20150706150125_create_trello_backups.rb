class CreateTrelloBackups < ActiveRecord::Migration
  def change
    create_table :trello_backups do |t|
      t.string :board
      t.text :data

      t.timestamps null: false
    end
  end
end
