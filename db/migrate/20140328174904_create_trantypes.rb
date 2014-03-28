class CreateTrantypes < ActiveRecord::Migration
  def change
    create_table :trantypes do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end
  end
end
