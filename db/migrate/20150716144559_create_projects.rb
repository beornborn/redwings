class CreateProjects < ActiveRecord::Migration
  
  def change
    create_table :projects do |t|
      t.string :name
      t.jsonb :data

      t.timestamps null: false
    end

    Project.create(:name => 'Academy', :data => '')
    Project.create(:name => 'Redwings', :data => '')
  end
end