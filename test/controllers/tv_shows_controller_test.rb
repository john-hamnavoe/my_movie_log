require 'test_helper'

class TvShowsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @tv_show = tv_shows(:tv_show_one)
  end
  
  test "should index if not logged on or not" do
    get tv_shows_path
    assert_response :success
    assert_select "a[href=?]", tmdb_tv_shows_path, { count: 0 }
    tv_shows = assigns(:tv_shows)
    assert_equal TvShow.count, tv_shows.count
    log_in_as(users(:michael))
    get tv_shows_path
    assert_response :success
    assert_select "a[href=?]", tmdb_tv_shows_path, { count: 1 }
    get tv_shows_path, params: { keywords: "My tv_show 1" }
    assert_response :success    
    tv_shows = assigns(:tv_shows)
    assert_equal 1, tv_shows.count   
    get tv_shows_path, params: { keywords: "My tv_show 1" }
    assert_response :success    
    tv_shows = assigns(:tv_shows)
    assert_equal 1, tv_shows.count      
  end

  test "should redirect edit if not logged on" do
    get edit_tv_show_path(@tv_show.id)
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get edit_tv_show_path(@tv_show.id)
    assert_response :success
  end  
  
  test "should show with or without logged on" do
    get tv_show_path(@tv_show.id)
    assert_response :success
    log_in_as(users(:michael))
    get tv_show_path(@tv_show.id)
    assert_response :success
    tv_show = assigns(:tv_show)
    assert_equal tv_show.name, @tv_show.name
  end  
end
