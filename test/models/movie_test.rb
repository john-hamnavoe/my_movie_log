require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.new(title: "Reservoir Dogs", year: 1992, tmdb_id: 500,
                       imdb_id: "tt0105236", tmdb_poster_path: "/tB2ITHg556e7aTV6cqQqVAXkdxN.jpg")
    @movie_one = movies(:movie_one)
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
  
  test "tmdb_id allow multiple nil" do
    @movie.tmdb_id = nil
    assert @movie.valid?
  end
  
  test "imdb_id allow multiple nil" do
    @movie.imdb_id = nil
    assert @movie.valid?
  end
  
  test "tmdb_id be unique if set" do
    @movie.tmdb_id = @movie_one.tmdb_id
    assert_not @movie.valid?
  end
  
  test "imdb_id be unique if set" do
    @movie.imdb_id = @movie_one.imdb_id
    assert_not @movie.valid?
  end  
end
