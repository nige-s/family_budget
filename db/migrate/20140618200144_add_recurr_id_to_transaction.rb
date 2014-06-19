class AddRecurrIdToTransaction < ActiveRecord::Migration
  def change
    add_column  :transactions, :recurring_trans_id, :integer
  end
end
