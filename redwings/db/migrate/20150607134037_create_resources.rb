class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.belongs_to :resource_stories, index: true
      t.string :url
      t.text   :description
      t.string :type
      t.timestamps null: false
    end
  end
end
