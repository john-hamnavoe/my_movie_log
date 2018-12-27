class AddReleasedToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :released, :boolean, default: true
  end
end
