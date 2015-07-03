class AddAdditionalFields < ActiveRecord::Migration
  def change
  	add_column :users, :deleted, :boolean
    add_column :users, :image_48, :string
  end
end

