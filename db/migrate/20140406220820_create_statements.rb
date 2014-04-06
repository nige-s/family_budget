class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.integer :acc_id
      t.date :edate

      t.timestamps
    end
  end
end
