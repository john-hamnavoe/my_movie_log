class AddTvShowSeasonToWatch < ActiveRecord::Migration[5.1]
  def change
    add_reference :watches, :tv_show_season, foreign_key: true
  end
end
