class AddUniqueIndexWatchLikes < ActiveRecord::Migration[5.1]
  def change
    add_index :watch_likes, [:watch_id, :friend_id], unique: true
  end
end
