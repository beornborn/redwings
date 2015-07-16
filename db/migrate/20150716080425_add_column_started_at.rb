class AddColumnStartedAt < ActiveRecord::Migration

  def change
    add_column :users, :started_at, :datetime
  end

end

