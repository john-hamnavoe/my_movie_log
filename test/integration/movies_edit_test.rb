require 'test_helper'

class MoviesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @movie = movies(:movie_one)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_movie_path(@movie)
    assert_template 'movies/edit'
    patch movie_path(@movie), params: {movie: {title: "",
                                            year: 1849 }}
    assert_template 'movies/edit'
    assert flash.empty?
  end
  
  test "successful edit" do
    log_in_as(@user)
    title = "New Movie Title"
    year = @movie.year - 10;
    assert_equal true, @movie.released
    release_date = '1/1/2010'.to_date
    patch movie_path(@movie), params: {movie: {title: title,
                                            year: year, released: false,
                                            release_date: release_date}} 
    assert_not flash.empty?
    assert_redirected_to movies_path
    @movie.reload
    assert_equal title, @movie.title
    assert_equal year, @movie.year
    assert_equal false, @movie.released
    assert_equal release_date, @movie.release_date
  end
  
  test "should redirect update when not logged in" do
    patch movie_path(@movie), params: {movie: {title: @movie.title,
                                            year: @movie.year }} 
    assert_not flash.empty?
    assert_redirected_to login_path
  end  
end
