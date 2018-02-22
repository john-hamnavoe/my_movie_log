class Watch < ApplicationRecord
  scope :details, -> { includes(:movie).order(date: :desc) } 

  belongs_to :user
  belongs_to :movie
  belongs_to :location, optional: true
  belongs_to :subscription, optional: true
  
  validates :rating, inclusion: 0..5, allow_nil: true
  validates :date, presence: true
end
