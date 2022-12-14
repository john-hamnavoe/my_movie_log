# frozen_string_literal: true

class Subscription < ApplicationRecord
  default_scope { includes(:subscription_period, :payment_type) }

  belongs_to :user
  belongs_to :subscription_period
  belongs_to :payment_type, optional: true
  has_many  :subscription_payments
  has_many  :watches

  validates :name, presence: true, length: { maximum: 75 }
  validates :amount, presence: true
  validates :start_date, presence: true

  validate  :end_date_after_start_date?

  def end_date_after_start_date?
    return if [start_date.blank?, end_date.blank?].any?
    if start_date > end_date
      errors.add(:end_date, 'end date must be after start date')
    end
  end

  def self.subscriptions_for_user(user_id)
    Subscription.where(user_id: user_id).order(:name)
  end

  def self.subscriptions_due
    today = Date::today
    Subscription.where(next_due_date: nil).or(
      Subscription.where('next_due_date <= ?', today)).where(
        'end_date is null OR end_date >= ?', today)
  end
end
