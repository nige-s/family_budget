class ChangeSignColumnDefault < ActiveRecord::Migration
  def change
  	change_column_default(:reports, :sign, nil)
  	change_column_default(:transactions, :sign, nil)
  end
end
