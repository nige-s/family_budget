class AddSignColumnTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :sign, :string, default: "DEBIT"
  end
end
