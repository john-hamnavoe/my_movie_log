# frozen_string_literal: true

module SubscriptionsHelper

  def cost_per_movie(amount, watches_count)
    (amount/watches_count).round(2) if watches_count != nil && watches_count > 0
  end
end
