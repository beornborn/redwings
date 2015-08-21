class AddFinishedAtUserColumn < ActiveRecord::Migration
  def change
    add_column :users, :finished_at, :datetime
  end
end
