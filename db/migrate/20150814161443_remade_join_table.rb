class RemadeJoinTable < ActiveRecord::Migration
  def change
    change_table(:projects_users) do |t|
      t.remove_timestamps
      t.remove :id
      t.remove :data
      t.index :project_id
      t.index :user_id
    end
  end
end

