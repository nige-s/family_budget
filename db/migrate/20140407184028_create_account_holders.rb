class CreateAccountHolders < ActiveRecord::Migration
  def change
    create_table :account_holders do |t|
      t.integer :user_id
      t.integer :account_id
      t.integer :privilege

      t.timestamps
    end
  end
end
