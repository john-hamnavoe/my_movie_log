require 'test_helper'

class WatchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_michael = users(:michael)
    @user_archer = users(:archer)
    @watch = watches(:one)
  end
  
  test "should get index when logged in" do
    get watches_path
    assert_redirected_to login_path
    log_in_as(@user_michael)
    get watches_path
    assert :success
    watches = assigns(:watches)
    assert_equal 4, watches.count
    assert watches.each_cons(2).all? { |x, y| x[:date] >= y[:date] }, 'Watches returned in order'
  end

  test "should get new when logged in and have movie_id" do
    movie = movies(:movie_one)
    get new_watch_path, params: { movie_id: movie.id }
    assert_redirected_to login_path
    log_in_as(@user_michael)    
    get new_watch_path, params: { movie_id: movie.id }
    assert :success
    watch = assigns(:watch)
    assert_equal movie.id, watch.movie_id
    found_movie = assigns(:movie)
    assert_equal movie.id, found_movie.id
    subscriptions = assigns(:subscriptions)
    assert_not subscriptions.nil?
    assert_equal 2, subscriptions.count
    assert subscriptions.each.all? { |s| s[:user_id] == @user_michael.id }, 'subscriptions belong to correct customer'
    get new_watch_path
    assert_redirected_to movies_path
    assert_not flash.empty?
  end

  test "should get edit when logged in and have movie_id" do
    get edit_watch_path(@watch.id)
    assert_redirected_to login_path
    log_in_as(@user_michael)    
    get edit_watch_path(@watch.id)
    assert :success
    watch = assigns(:watch)
    assert_equal @watch.movie_id, watch.movie_id
    found_movie = assigns(:movie)
    assert_equal @watch.movie_id, found_movie.id
    subscriptions = assigns(:subscriptions)
    assert_not subscriptions.nil?
    assert_equal 2, subscriptions.count
    assert subscriptions.each.all? { |s| s[:user_id] == users(:michael).id }, 'subscriptions belong to correct customer'
  end  
  
  test "edit redirect if invalid request" do
    log_in_as(@user_archer)
    get edit_watch_path @watch.id
    assert_redirected_to watches_path
  end 

end
