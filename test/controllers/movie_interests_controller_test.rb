require 'test_helper'

class MovieInterestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @movie = movies(:movie_three)    
    @movie_one = movies(:movie_one)
    @movie_interest = movie_interests(:one)
    @archer = users(:archer)
    @lana = users(:lana)
  end
  
  test "should not create if not logged in" do
    assert_no_difference "MovieInterest.count" do
      post movie_interests_path, params: { movie_id: @movie.id }
    end
    assert_redirected_to login_path
  end
  
  test "should create" do
    log_in_as(@archer)
    assert_difference "MovieInterest.count", +1 do
      post movie_interests_path, params: { movie_id: @movie.id }
    end
    assert_redirected_to upcoming_movies_path
    movie_interest = MovieInterest.find_by(movie_id: @movie.id, user_id: @archer.id )
    assert_equal movie_interest.movie_id, @movie.id
  end

  test "should not destroy if not logged_in " do
    assert_no_difference "MovieInterest.count" do
      delete movie_interest_path(@movie_interest.id)
    end
    assert_redirected_to login_path    
  end

  test "should destroy" do
    log_in_as(@lana)
    assert_difference "MovieInterest.count", -1 do
      delete movie_interest_path(@movie_interest.id)
    end
    assert_redirected_to upcoming_movies_path    
    movie_interest = MovieInterest.find_by(movie_id: @movie_one.id, user_id: @lana.id )
    assert_nil movie_interest  
  end
  
  test "should not destroy wrong user" do
    log_in_as(users(:archer))
    assert_no_difference "MovieInterest.count" do
      delete movie_interest_path(@movie_interest.id)
    end
    assert_redirected_to upcoming_movies_path    
  end
end
