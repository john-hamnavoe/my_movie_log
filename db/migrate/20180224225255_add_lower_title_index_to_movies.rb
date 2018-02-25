class AddLowerTitleIndexToMovies < ActiveRecord::Migration[5.1]
  def change
    ActiveRecord::Base.connection.execute('create index index_lower_title_on_movies on movies using gin (lower(title) gin_trgm_ops) ;')
  end
end
