require 'test_helper'

class TmdbMoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tmdb_movies_path
    tmdb_movies = assigns(:tmdb_movies)
    assert_response :success
    assert_equal 20, tmdb_movies.count
    get tmdb_movies_path( keywords: "the man who shot liberty valance")
    tmdb_movies = assigns(:tmdb_movies)
    assert_response :success
    assert_equal 1, tmdb_movies.count  
    assert_equal "The Man Who Shot Liberty Valance", tmdb_movies[0]["title"]
    get tmdb_movies_path( keywords: "the life and times of john h wallace")
    tmdb_movies = assigns(:tmdb_movies)
    assert_response :success
    assert_equal 0, tmdb_movies.count     
  end
  
  test "should get show" do
    liberty_valance_id = 11697
    path = new_movie_path( tmdb_id: liberty_valance_id )
    get tmdb_movie_path liberty_valance_id
    tmdb_movie = assigns(:tmdb_movie)
    assert_response :success
    assert_equal "The Man Who Shot Liberty Valance", tmdb_movie["title"]
    assert_match "1962", response.body
    assert_select "a[href=?]", path , { count: 1 }
  end

end
