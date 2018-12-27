class CreateMovieFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_favourites do |t|
      t.references :movie, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
