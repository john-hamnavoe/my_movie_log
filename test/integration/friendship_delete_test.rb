require 'test_helper'

class FriendshipDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user_5 = users(:user_5)
    @friend = users(:user_6)
    @friend_other = users(:user_8)
  end
  
  test "should delete if logged in" do
    delete friends_destroy_path(@friend)
    assert_redirected_to login_path
    log_in_as(@user_5)
    assert_difference 'Friendship.count', -2 do
      delete friends_destroy_path, params: {id: @friend.id }
    end
    assert_redirected_to users_path
  end 
  
  test "should not delete other user" do
    log_in_as(@user_5)
    assert_no_difference 'Friendship.count' do
      delete friends_destroy_path, params: {id: @friend_other.id }
    end
    assert_redirected_to users_path
  end
end
