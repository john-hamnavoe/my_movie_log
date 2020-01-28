class TvShowSeason < ApplicationRecord
  belongs_to :tv_show
  
  has_many :watches
  
  scope :ordered, -> { order(number: :asc) }

  def tmdb_url
    "https://www.themoviedb.org/tv/#{tmdb_id}/season/#{number}"
  end
end
