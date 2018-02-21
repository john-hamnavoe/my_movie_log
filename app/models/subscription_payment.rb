class SubscriptionPayment < ApplicationRecord
  belongs_to :subscription
  
  validates :end_date, presence: true
  validates :start_date, presence: true
  validates :amount, presence: true

  validate  :end_date_after_start_date?

  def end_date_after_start_date?
    return if [start_date.blank?, end_date.blank?].any?
    if start_date > end_date
      errors.add(:end_date, 'end date must be after start date')
    end
  end  
end
