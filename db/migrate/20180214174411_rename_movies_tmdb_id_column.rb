class RenameMoviesTmdbIdColumn < ActiveRecord::Migration[5.1]
  def change
     rename_column :movies, :tmdb_db_id, :tmdb_id
  end
end
