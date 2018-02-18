class CreateWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :watches do |t|
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.date :date
      t.integer :rating
      t.text :review
      t.references :location, foreign_key: true
      t.references :subscription, foreign_key: true
      t.decimal :paid, precision: 5, scale: 2

      t.timestamps
    end
  end
end
