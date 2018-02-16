class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.date :start_date
      t.decimal :amount, precision: 5, scale: 2
      t.references :subscription_period, foreign_key: true
      t.date :end_date
      t.references :payment_type, foreign_key: true
      t.string :reference

      t.timestamps
    end
  end
end
