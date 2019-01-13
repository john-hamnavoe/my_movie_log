class AddFullPriceAmountToSubscriptionPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :subscription_payments, :full_price_amount, :decimal, precision: 5, scale: 2
  end
end
