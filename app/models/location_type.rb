# frozen_string_literal: true

class LocationType < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
end
