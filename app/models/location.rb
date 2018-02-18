# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :location_type
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: {maximum: 75 }
  validates :post_code, length: {maximum: 10 }
  validates :website, length: {maximum: 255 }
end
