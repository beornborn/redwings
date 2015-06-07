class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :stories, index: true
      t.integer :story_id
      t.integer :user_id
      t.boolean :ready
      t.string  :ancestry
      t.timestamps null: false
    end
  end
end
