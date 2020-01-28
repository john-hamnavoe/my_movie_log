class CreateTvShows < ActiveRecord::Migration[5.1]
  def change
    create_table :tv_shows do |t|
      t.integer :tmdb_id, index: true

      t.string :name, index: true
      t.string :overview
      t.string :homepage

      t.date :first_air_date
      t.date :last_air_date

      t.string :poster_path
      t.string :backdrop_path
      
      t.timestamps
    end
  end
end
