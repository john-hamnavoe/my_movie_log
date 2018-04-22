class AddSubscriptionPaymentToWatch < ActiveRecord::Migration[5.1]
  def change
    add_reference :watches, :subscription_payment, foreign_key: true
  end
end
