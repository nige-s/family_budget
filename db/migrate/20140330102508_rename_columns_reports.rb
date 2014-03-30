class RenameColumnsReports < ActiveRecord::Migration
  def change
  	rename_column :reports, :user, :user_id
  	rename_column :reports, :category, :category_id
  	rename_column :reports, :trantype, :trantype_id
  	add_column :reports, :sign, :string, default: "DEBIT"
  end
end
