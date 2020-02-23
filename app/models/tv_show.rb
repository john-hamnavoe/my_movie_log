class TvShow < ApplicationRecord
  has_many :tv_show_seasons
  
  validates :name, presence: true,
                    length: { maximum: 255 }


  validates :tmdb_id, uniqueness: { allow_nil: true }

  self.per_page = 10
  
  scope :posters, -> { where.not(poster_path: [nil, ""]).select("poster_path AS tmdb_poster_path") }
  
  def tmdb_url
    "https://www.themoviedb.org/tv/#{tmdb_id}"
  end
  
  def self.average_rating(id)
     Watch.joins(:tv_show_season).where(tv_show_seasons: {tv_show_id: id}).where.not(rating: nil).average(:rating).to_f.round(2)
  end

  def self.total_watches(id)
    Watch.joins(:tv_show_season).where(tv_show_seasons: {tv_show_id: id}).count
  end

  def self.last_reviews(id, number_of_reviews)
    Watch.joins(:tv_show_season).where(tv_show_seasons: {tv_show_id: id}).order(created_at: :desc).limit(number_of_reviews)
  end
end
