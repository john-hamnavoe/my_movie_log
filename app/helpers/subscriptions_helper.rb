# frozen_string_literal: true

module SubscriptionsHelper
  def cost_per_movie(amount, watches_count)
    (amount / watches_count).round(2) if watches_count != nil && watches_count > 0
  end

  def total_full_price(full_price_amount, watches_count)
    (full_price_amount * watches_count).round(2) if full_price_amount != nil && watches_count != nil
  end

  def total_savings(amount, full_price_amount, watches_count)
    total_full_price_amount = total_full_price(full_price_amount, watches_count)
    ((total_full_price_amount || 0) - amount).round(2)
  end
end
