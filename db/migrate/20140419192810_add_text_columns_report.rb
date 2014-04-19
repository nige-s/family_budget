class AddTextColumnsReport < ActiveRecord::Migration
  def change
  	add_column :reports, :description, :string
  	add_column :reports, :supplier, :string
    add_column :reports, :amount, :decimal
  end
end
