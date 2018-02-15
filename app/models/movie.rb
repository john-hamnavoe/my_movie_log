class Movie < ApplicationRecord
  
  validates :title, presence: true, 
                    length: { maximum: 255 }  
  validates :year, presence: true,
                   numericality: { greater_than_or_equal_to: 1850 }
  validates :tmdb_id, uniqueness: { allow_nil: true }
  validates :imdb_id, uniqueness: { allow_nil: true }
  
  self.per_page = 10
end
