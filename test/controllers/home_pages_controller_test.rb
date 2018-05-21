require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "my movie log" 
  end
  
  test "should get home" do
    get root_path
    top_10_movies = assigns(:top_10_movies)
    top_10_month_movies = assigns(:top_10_movies_last_month)
    users_count = assigns(:users_count)
    assert_response :success
    assert_select "title", "home | #{@base_title}"
    assert_equal top_10_movies.length, 2
    assert_equal top_10_month_movies.length, 1
    assert_equal users_count, 34
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "contact | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "about | #{@base_title}"    
  end

end
