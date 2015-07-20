class AddGinIndex < ActiveRecord::Migration

  def change
    add_index :projects, :data, using: :gin
  end

end

