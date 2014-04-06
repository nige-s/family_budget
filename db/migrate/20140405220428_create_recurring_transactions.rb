class CreateRecurringTransactions < ActiveRecord::Migration
  def change
    create_table :recurring_transactions do |t|
      t.integer :account_id
      t.string :interval
      t.string :description
      t.decimal :amount
      t.string :sign
      t.boolean :active
      t.date :start_date
      t.date :end_date
      t.date :last_updated
      t.integer :day

      t.timestamps
    end
  end
end
