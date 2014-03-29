class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user
      t.integer :category
      t.integer :trantype
      t.date :sdate
      t.date :edate

      t.timestamps
    end
  end
end
