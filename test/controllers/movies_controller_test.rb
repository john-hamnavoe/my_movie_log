require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @movie = movies(:movie_one)
    @liberty_valance_id = 11697
  end
  
  test "should index if not logged on or not" do
    get movies_path
    assert_response :success
    assert_select "a[href=?]", tmdb_movies_path, { count: 0 }
    movies = assigns(:movies)
    assert_equal Movie.count, movies.count
    log_in_as(users(:michael))
    get movies_path
    assert_response :success
    assert_select "a[href=?]", tmdb_movies_path, { count: 1 }
    get movies_path, params: { keywords: "My Movie 1" }
    assert_response :success    
    movies = assigns(:movies)
    assert_equal 1, movies.count   
    get movies_path, params: { keywords: "my MOVIE 1" }
    assert_response :success    
    movies = assigns(:movies)
    assert_equal 1, movies.count      
  end
  
  test "should redirect new if not logged on" do
    get new_movie_path
    assert_redirected_to login_path
  end 
  
  test "should get new if logged on" do
    log_in_as(users(:michael))
    get new_movie_path
    assert_response :success
    movie = assigns(:movie)
    assert movie.title.nil?
    get new_movie_path, params: {tmdb_id: @liberty_valance_id }
    assert_response :success
    movie = assigns(:movie)     
    assert_equal "The Man Who Shot Liberty Valance", movie.title
    assert_equal 1962, movie.year
    assert_equal "tt0056217", movie.imdb_id
    assert_equal @liberty_valance_id, movie.tmdb_id
    assert_equal "/qEczX5Rruux72XOHDeeLJEvmZkV.jpg", movie.tmdb_poster_path
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
