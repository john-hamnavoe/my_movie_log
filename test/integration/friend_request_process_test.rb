require 'test_helper'

class FriendRequestProcessTest < ActionDispatch::IntegrationTest
  def setup 
    @user_michael = users(:michael)
    @user_archer = users(:archer)
  end

  test "create friend request if logged in" do
    assert_no_difference "FriendRequest.count" do
      post friend_requests_path, params: { friend_id: @user_archer.id }
    end
    assert_redirected_to login_path
    
    log_in_as(@user_michael)
    assert_difference "FriendRequest.count", +1 do
      post friend_requests_path, params: { friend_id: @user_archer.id }
    end
    assert_redirected_to users_path
  end

  test "create and accept friend request" do
    log_in_as(@user_michael)
    assert_difference "FriendRequest.count", +1 do
      post friend_requests_path, params: { friend_id: @user_archer.id }
    end
    assert_redirected_to users_path
    friend_request = assigns(:friend_request)
    assert_not friend_request.nil?
    assert_difference "FriendRequest.count", -1 do 
      assert_difference "Friendship.count", +2 do
        patch friend_request_path(friend_request)
      end
    end
  end
  
  test "create and decline friend request" do
    log_in_as(@user_michael)
    assert_difference "FriendRequest.count", +1 do
      post friend_requests_path, params: { friend_id: @user_archer.id }
    end
    assert_redirected_to users_path
    friend_request = assigns(:friend_request)
    assert_not friend_request.nil?
    log_in_as(@user_archer)
    assert_difference "FriendRequest.count", -1 do 
      assert_no_difference "Friendship.count" do
        delete friend_request_path(friend_request)
      end
    end
    log_in_as(@user_michael)
    assert_difference "FriendRequest.count", +1 do
      post friend_requests_path, params: { friend_id: @user_archer.id }
    end
    assert_redirected_to users_path
    friend_request = assigns(:friend_request)
    assert_not friend_request.nil?
    assert_difference "FriendRequest.count", -1 do 
      assert_no_difference "Friendship.count" do
        delete friend_request_path(friend_request)
      end
    end    
  end  
  
  test "handle failure to create friend request" do
    log_in_as(@user_michael)
    assert_difference "FriendRequest.count", +1 do
      post friend_requests_path, params: { friend_id: @user_archer.id }
    end
    assert_redirected_to users_path
    assert_no_difference "FriendRequest.count" do
      post friend_requests_path, params: { friend_id: @user_archer.id }
    end
    assert_not flash.empty?
    assert_redirected_to users_path
  end    
end
