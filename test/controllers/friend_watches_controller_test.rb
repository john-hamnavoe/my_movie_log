require 'test_helper'

class FriendWatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friend_watches_index_url
    assert_response :success
  end

end
