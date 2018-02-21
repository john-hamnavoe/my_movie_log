class AddNextDueDateToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :next_due_date, :date
  end
end
