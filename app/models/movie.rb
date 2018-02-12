class Movie < ApplicationRecord
  
  validates :title, presence: true, 
                    length: { maximum: 255 }  
  validates :year, presence: true,
                   numericality: { greater_than_or_equal_to: 1850 }
end
