class AddTmdbIndexToMovies < ActiveRecord::Migration[5.1]
  def change
    add_index :movies, :tmdb_id, unique: true
  end
end
