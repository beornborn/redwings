class AddColumnSkipPasswordValidation < ActiveRecord::Migration

  def change
  	add_column :users, :skip_password_validation, :boolean, :default => false
  end

end

