class RenameTrantypeAccountidReports < ActiveRecord::Migration
  def change
  	rename_column :reports, :trantype_id, :account_id
  end
end
