# frozen_string_literal: true

class PaymentType < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
end
