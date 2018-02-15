class AddImdbIndexToMovies < ActiveRecord::Migration[5.1]
  def change
    add_index :movies, :imdb_id, unique: true
  end
end
