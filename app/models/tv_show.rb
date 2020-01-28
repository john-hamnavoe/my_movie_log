class TvShow < ApplicationRecord
  has_many :tv_show_seasons
  
  validates :name, presence: true,
                    length: { maximum: 255 }


  validates :tmdb_id, uniqueness: { allow_nil: true }

  self.per_page = 10
  
  def tmdb_url
    "https://www.themoviedb.org/tv/#{tmdb_id}"
  end
end
