class RenameJoinTableName < ActiveRecord::Migration

  def change
    rename_table :project_users, :projects_users
  end

end

