require 'test_helper'

class WatchesEditTest < ActionDispatch::IntegrationTest
  def setup
    @watch = watches(:one)
    @user_michael = users(:michael)
    @user_archer = users(:archer)
  end
  
  test "should not update without login" do
    assert_no_difference 'Watch.count' do
      patch watch_path(@watch), params: { watch: { rating: 0, 
        date: @watch.date, paid: @watch.paid} }
    end
    assert_redirected_to login_path    
  end
  
  test "should update with login" do
    rating = 3
    paid = 1.99
    log_in_as(@user_michael)
    assert_no_difference 'Watch.count' do
      patch watch_path(@watch), params: { watch: { rating: rating, 
        date: @watch.date, paid: paid} }
    end
    assert_not flash.empty?
    assert_redirected_to watches_path
    @watch.reload
    assert_equal rating, @watch.rating
    assert_equal paid, @watch.paid
  end  
  
  test "should not update with login and invalid details" do
    rating = -99
    log_in_as(@user_michael)
    assert_no_difference 'Watch.count' do
      patch watch_path(@watch), params: { watch: { rating: rating, 
        date: @watch.date, paid: @watch.paid} }
    end
    assert_template 'watches/edit'
    assert flash.empty?
    @watch.reload
    assert_not_equal rating, @watch.rating
    movie = assigns(:movie)
    assert_equal @watch.movie_id, movie.id
    subscriptions = assigns(:subscriptions)
    assert_not subscriptions.nil?
  end    
  
  test "should not update with wrong login" do
    rating = 3
    paid = 2.99
    log_in_as(@user_archer)
    assert_no_difference 'Watch.count' do
      patch watch_path(@watch), params: { watch: { rating: rating, 
        date: @watch.date, paid: paid} }
    end
    assert_redirected_to watches_path
    @watch.reload
    assert_not_equal rating, @watch.rating
    assert_not_equal paid, @watch.paid
    assert flash.empty?
  end   
end
