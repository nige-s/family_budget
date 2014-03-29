class AddRangeColumnReports < ActiveRecord::Migration
  def change

    add_column :reports, :range, :boolean, default: false
  end
end
