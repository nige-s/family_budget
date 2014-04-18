class AddCategoryArrayReport < ActiveRecord::Migration
  def change
  	add_column    :reports, :category_ids, :integer, array: true, default: []
  	add_column    :reports, :trantype_ids, :integer, array: true, default: []
  	remove_column :reports, :category_id
  	remove_column :reports, :trantype_id
  end
end
