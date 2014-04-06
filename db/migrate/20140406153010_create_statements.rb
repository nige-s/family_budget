class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.integer :acc_id
      t.integer :sdate
      t.integer :edate

      t.timestamps
    end
  end
end
