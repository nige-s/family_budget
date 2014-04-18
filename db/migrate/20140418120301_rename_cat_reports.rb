class RenameCatReports < ActiveRecord::Migration
  def change
  	rename_column :reports, :category_ids, :category_id
  	rename_column :reports, :trantype_ids, :trantype_id
  end
end
