class CreateProjects < ActiveRecord::Migration

  def change
    create_table :projects do |t|
      t.string :name
      t.jsonb :data, default: '{}'

      t.timestamps null: false
    end

    Project.create(name: 'Academy')
    Project.create(name: 'Redwings')
  end
end
