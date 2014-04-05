class CreateAccountTransactions < ActiveRecord::Migration
  def change
    create_table :account_transactions do |t|
      t.integer :account_id
      t.date :tran_date
      t.string :description
      t.decimal :amount
      t.string :sign

      t.timestamps
    end
  end
end
