class AddGoodbyeReasonColumn < ActiveRecord::Migration

  def change
    add_column :users, :goodbye_reason, :string, default: nil
  end

end

