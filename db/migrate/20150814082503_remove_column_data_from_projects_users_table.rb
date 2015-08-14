class RemoveColumnDataFromProjectsUsersTable < ActiveRecord::Migration
  def change
    remove_column :projects_users, :data, :jsonb
  end
end

