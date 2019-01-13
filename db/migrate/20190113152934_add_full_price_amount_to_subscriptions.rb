class AddFullPriceAmountToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :full_price_amount, :decimal, precision: 5, scale: 2
  end
end
