require 'test_helper'

class MovieInterestTest < ActiveSupport::TestCase
  def setup 
    @movie = movies(:movie_three)
    @user = users(:lana)
  end

  test "shoud not be valid" do  
    movie_interest = MovieInterest.new
    assert_not movie_interest.valid?
    movie_interest.movie_id = @movie.id
    assert_not movie_interest.valid?
    movie_interest.movie_id = nil
    movie_interest.user_id = @user.id
    assert_not movie_interest.valid?    
  end
  
  test "should be valid" do
    movie_interest = MovieInterest.new(movie_id: @movie.id, user_id: @user.id)
    assert movie_interest.valid?
  end
  
  test "should not have interest in same movie" do
    movie_interest = MovieInterest.new(movie_id: @movie.id, user_id: @user.id)
    movie_interest.save!
    movie_interest_dup = MovieInterest.new(movie_id: @movie.id, user_id: @user.id)
    assert_not movie_interest_dup.valid?
  end  
end
