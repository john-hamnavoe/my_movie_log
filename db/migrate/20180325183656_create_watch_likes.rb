class CreateWatchLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :watch_likes do |t|
      t.references :watch, foreign_key: true
      t.references :friend, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
