class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :tmdb_db_id
      t.integer :year
      t.string :imdb_id
      t.string :tmdb_poster_path

      t.timestamps
    end
  end
end
