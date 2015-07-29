class AddColumnGoodbyeLetter < ActiveRecord::Migration

  def change
  	add_column :users, :goodbye_letter, :string, default: nil
  end

end

