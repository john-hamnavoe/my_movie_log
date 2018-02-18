class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.references :location_type, foreign_key: true
      t.string :website
      t.string :post_code

      t.timestamps
    end
  end
end
