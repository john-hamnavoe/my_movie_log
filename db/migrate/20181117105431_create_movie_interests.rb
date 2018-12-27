class CreateMovieInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_interests do |t|
      t.references :movie, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
