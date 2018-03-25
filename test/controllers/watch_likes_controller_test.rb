require 'test_helper'

class WatchLikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @watch = watches(:three)    
    @watch_like = watch_likes(:one)
  end
  
  test "should not create if not logged in" do
    assert_no_difference "WatchLike.count" do
      post friend_requests_path, params: { watch_id: @watch.id }
    end
    assert_redirected_to login_path
  end
  
  test "should create" do
    log_in_as(users(:archer))
    assert_difference "WatchLike.count", +1 do
      post watch_likes_path, params: { watch_id: @watch.id }
    end
    assert_redirected_to friend_feed_path
  end

  test "should not destroy if not logged_in " do
    assert_no_difference "WatchLike.count" do
      delete watch_like_path(@watch_like.id)
    end
    assert_redirected_to login_path    
  end

  test "should destroy" do
    log_in_as(users(:lana))
    assert_difference "WatchLike.count", -1 do
      delete watch_like_path(@watch_like.id)
    end
    assert_redirected_to friend_feed_path    
  end
  
  test "should not destroy wrong user" do
    log_in_as(users(:archer))
    assert_no_difference "WatchLike.count" do
      delete watch_like_path(@watch_like.id)
    end
    assert_redirected_to friend_feed_path    
  end
  
end
