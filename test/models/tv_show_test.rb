require 'test_helper'

class TvShowTest < ActiveSupport::TestCase
  def setup
    @tv_show = TvShow.new(name: "The Walking Dead", tmdb_id: 1402,
                        poster_path: "/reKs8y4mPwPkZG99ZpbKRhBPKsX.jpg")
    @tv_show_one = tv_shows(:tv_show_one)
  end
  
  test "should be valid" do
    assert @tv_show.valid?
  end
  
  test "title should not be blank" do
    @tv_show.name = "       "
    assert_not @tv_show.valid?
  end
  
  test "tmdb_id allow multiple nil" do
    @tv_show.tmdb_id = nil
    assert @tv_show.valid?
  end
  
  test "tmdb_id be unique if set" do
    @tv_show.tmdb_id = @tv_show_one.tmdb_id
    assert_not @tv_show.valid?
  end
end
