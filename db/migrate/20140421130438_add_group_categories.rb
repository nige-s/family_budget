class AddGroupCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :group, :string, default: "user"
  end
end
