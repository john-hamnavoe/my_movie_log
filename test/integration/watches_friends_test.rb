require 'test_helper'

class WatchesFriendsTest < ActionDispatch::IntegrationTest
  def setup
    @watch = watches(:one)
    @watch_no_friends = watches(:three)
    @user_michael = users(:michael)
  end
  
  test "should find friends with no login" do
    get watch_friends_path(@watch.id)
    assert_redirected_to login_path    
  end
  
  test "should find friends" do
    log_in_as(@user_michael)
    get watch_friends_path(@watch.id)
    assert_template 'watches/friends'   
    friends = assigns(:friends)
    assert_equal 2, friends.length
  end
  
  test "should find no friends" do
    log_in_as(@user_michael)
    get watch_friends_path(@watch_no_friends.id)
    assert_template 'watches/friends'   
    friends = assigns(:friends)
    assert_equal 0, friends.length
  end  
end
