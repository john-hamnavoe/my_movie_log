class MovieInterest < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  
  validates :movie, uniqueness: { scope: :user }
end
