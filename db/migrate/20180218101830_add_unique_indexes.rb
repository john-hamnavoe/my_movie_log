class AddUniqueIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :subscription_periods, :name, unique: true
    add_index :location_types, :name, unique: true
    add_index :payment_types, :name, unique: true
    add_index :locations, :name, unique: true
  end
end
