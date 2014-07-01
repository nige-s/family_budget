class AddReconAndReconDateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :reconciled, :boolean, default: false
    add_column :transactions, :reconciled_date, :date
  end
end
