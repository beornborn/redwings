class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :project_users do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.jsonb :data, default: '{}'

      t.timestamps null: false
    end

    add_index :project_users, :data, using: :gin
  end
end
