class RenameTrantypeToAccountidTransactions < ActiveRecord::Migration
  def change
  	rename_column :transactions, :trantype_id, :account_id
  end
end
