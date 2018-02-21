class CreateSubscriptionPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_payments do |t|
      t.references :subscription, foreign_key: true
      t.decimal :amount, precision: 5, scale: 2
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
