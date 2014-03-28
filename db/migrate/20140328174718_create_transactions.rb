class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.date :tran_date
      t.integer :trantype_id
      t.integer :category_id
      t.string :description
      t.string :supplier
      t.decimal :amount

      t.timestamps
    end
  end
end
