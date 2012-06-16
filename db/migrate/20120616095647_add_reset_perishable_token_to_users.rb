class AddResetPerishableTokenToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :reset_perishable_token, :string
  end

  def down
  	remove_column :users, :reset_perishable_token	
  end
end
