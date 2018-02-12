require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @movie = movies(:movie_one)
  end
  
  test "should index if not logged on or not" do
    get movies_path
    assert_response :success
    assert_select "a[href=?]", new_movie_path, { count: 0 }
    log_in_as(users(:michael))
    get movies_path
    assert_response :success
    assert_select "a[href=?]", new_movie_path, { count: 1 }
  end
  
  test "should redirect new if not logged on" do
    get new_movie_path
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get new_movie_path
    assert_response :success
  end 
  
  test "should redirect edit if not logged on" do
    get edit_movie_path(@movie.id)
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get edit_movie_path(@movie.id)
    assert_response :success
  end  
  
  test "should show with or without logged on" do
    get movie_path(@movie.id)
    assert_response :success
    log_in_as(users(:michael))
    get movie_path(@movie.id)
    assert_response :success
    movie = assigns(:movie)
    assert_equal movie.title, @movie.title
  end      
end
