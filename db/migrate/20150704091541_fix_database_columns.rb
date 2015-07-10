class FixDatabaseColumns < ActiveRecord::Migration
  def change
    rename_column :users, :name, :username
    rename_column :users, :lastname, :last_name
    add_column :users, :first_name, :string
  end
end

