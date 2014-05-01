class CreateBankTransfers < ActiveRecord::Migration
  def change
    create_table :bank_transfers do |t|
      t.integer :src_account_id
      t.integer :target_account_id
      t.date :tran_date
      t.decimal :amount
      t.string :description
      t.integer :src_user_id
      t.integer :target_user_id

      t.timestamps
    end
  end
end
