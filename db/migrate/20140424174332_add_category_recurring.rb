class AddCategoryRecurring < ActiveRecord::Migration
  def change
    add_column :recurring_transactions, :category_id, :integer
  end
end
