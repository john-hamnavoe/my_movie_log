require 'test_helper'

class FriendWatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friend_feed_path
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get friend_feed_path
    assert :success
  end

end
