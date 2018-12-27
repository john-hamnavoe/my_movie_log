require 'test_helper'

class UpcomingMoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @movie = movies(:movie_four)
  end

  test "should get index and links if logged in" do
    get upcoming_movies_path
    assert_response :success
    assert_select "a[href=?]", edit_movie_path(@movie.id), false
    assert_select "div#interested_state_#{@movie.id}", false
    assert_select "a[href=?]", release_movie_path(id: @movie.id), false
    log_in_as(users(:michael))
    get upcoming_movies_path
    assert_response :success
    assert_select "a[href=?]", edit_movie_path(@movie.id, params: {upcoming: true})  
    assert_select "div#interested_state_#{@movie.id}"
    assert_select "a[href=?]", release_movie_path(id: @movie.id)
  end

end
