class AddColumnSpentLearnTime < ActiveRecord::Migration
  def change
    add_column :users, :spent_learn_time, :integer, default: 0
  end
end
