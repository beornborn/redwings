class AddColumnSpentTime < ActiveRecord::Migration
  def change
  	add_column :users, :spent_time, :integer, default: 0
  end
end

