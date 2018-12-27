require 'test_helper'

class MoviesReleaseTest < ActionDispatch::IntegrationTest
  
  def setup
    @movie = movies(:movie_four)
  end

  test "should redirect update when not logged in" do
    patch release_movie_path(id: @movie.id)
    
    assert_not flash.empty?
    assert_redirected_to login_path
  end 
  
  test "should set to released" do
    log_in_as(users(:archer))
    assert_equal false, @movie.released
    patch release_movie_path(id: @movie.id)
    
    assert_not flash.empty?
    assert_redirected_to upcoming_movies_path
    @movie.reload
    assert_equal true, @movie.released  
  end 
end
