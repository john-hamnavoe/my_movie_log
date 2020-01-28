require 'test_helper'

class TmdbTvShowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tmdb_tv_shows_path
    tmdb_tv_shows = assigns(:tmdb_tv_shows)
    assert_response :success
    assert_equal 20, tmdb_tv_shows.count
    get tmdb_tv_shows_path( keywords: "the beechgrove garden")
    tmdb_tv_shows = assigns(:tmdb_tv_shows)
    assert_response :success
    assert_equal 1, tmdb_tv_shows.count  
    assert_equal "The Beechgrove Garden", tmdb_tv_shows[0]["name"]
    get tmdb_tv_shows_path( keywords: "the life and times of john h wallace")
    tmdb_tv_shows = assigns(:tmdb_tv_shows)
    assert_response :success
    assert_equal 0, tmdb_tv_shows.count     
  end
  
  test "should get show" do
    beechgrove_id = 16817
    path = create_tv_from_tmdb_path( tmdb_id: beechgrove_id )
    get tmdb_tv_show_path beechgrove_id
    tmdb_tv_show = assigns(:tmdb_tv_show)
    assert_response :success
    assert_equal "The Beechgrove Garden", tmdb_tv_show["name"]
  end
end
