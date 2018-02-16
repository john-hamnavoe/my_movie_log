class CreateSubscriptionPeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_periods do |t|
      t.string :name
      t.integer :months

      t.timestamps
    end
  end
end
