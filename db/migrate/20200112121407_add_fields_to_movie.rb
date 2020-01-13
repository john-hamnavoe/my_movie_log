class AddFieldsToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :tagline, :string
    add_column :movies, :overview, :string
    add_column :movies, :backdrop_path, :string
  end
end
