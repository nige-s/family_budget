class AddUserCategoriesTransactions < ActiveRecord::Migration
  def change
  	add_column :categories, :user_id, :integer
  	add_column :trantypes, :user_id, :integer
  end
end
