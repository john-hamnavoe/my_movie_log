require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.new(title: "Reservoir Dogs", year: 1992, tmdb_db_id: 500)
  end
  
  test "should be valid" do
    assert @movie.valid?
  end
  
  test "title should not be blank" do
    @movie.title = "       "
    assert_not @movie.valid?
  end
  
  test "year should not be blank and be valid range" do
    @movie.year = nil
    assert_not @movie.valid?
    @movie.year = 1849
    assert_not @movie.valid?
    @movie.year = -200
    assert_not @movie.valid?
  end
end
