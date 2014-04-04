class AddDateDefaultsReports < ActiveRecord::Migration
  def change
    change_column_default(:reports,:sdate, "01/03/2014")
    change_column_default(:reports,:edate, nil)
  end
end
