class AddWatchesCountToSubscriptionPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :subscription_payments, :watches_count, :integer
  end
end
