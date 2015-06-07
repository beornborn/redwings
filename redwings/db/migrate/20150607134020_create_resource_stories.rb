class CreateResourceStories < ActiveRecord::Migration
  def change
    create_table :resource_stories do |t|
      t.belongs_to :stories, index: true
      t.integer :resource_id
      t.integer :story_id
      t.integer :place_num
      t.timestamps null: false
    end
  end
end
