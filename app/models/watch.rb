# frozen_string_literal: true

class Watch < ApplicationRecord
  scope :details, -> { includes(:movie).includes(tv_show_season: :tv_show).order(date: :desc) }
  scope :no_payments, -> {
    where.not(subscription_id: nil).where(subscription_payment_id: nil) }

  belongs_to :user
  belongs_to :movie, optional: true
  belongs_to :tv_show_season, optional: true
  belongs_to :location, optional: true
  belongs_to :subscription, optional: true
  belongs_to :subscription_payment, optional: true, counter_cache: true

  has_many :watch_likes, dependent: :destroy

  validates :rating, inclusion: 0..5, allow_nil: true
  validates :date, presence: true

  self.per_page = 20
end
