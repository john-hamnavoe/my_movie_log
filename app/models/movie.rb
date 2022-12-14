# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 255 }
  validates :year, presence: true,
                   numericality: { greater_than_or_equal_to: 1850 }
  validates :tmdb_id, uniqueness: { allow_nil: true }
  validates :imdb_id, uniqueness: { allow_nil: true }

  has_many :watches 
  
  self.per_page = 10
  
  scope :posters, -> { where.not(tmdb_poster_path: [nil, ""]).select(:tmdb_poster_path) }
  
  def tmdb_url
    "https://www.themoviedb.org/movie/#{tmdb_id}"
  end

  def imdb_url
    "https://www.imdb.com/title/#{imdb_id}"
  end

  def self.average_rating(id)
     Watch.where(movie_id: id).where.not(rating: nil).average(:rating).to_f.round(2)
  end

  def self.total_watches(id)
    Watch.where(movie_id: id).count
  end

  def self.last_reviews(id, number_of_reviews)
    Watch.where(movie_id: id).order(created_at: :desc).limit(number_of_reviews)
  end
end
