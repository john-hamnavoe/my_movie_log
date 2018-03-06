require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @request = FriendRequest.new(user_id: users(:michael).id, friend_id: users(:archer).id)
    @request_dup = FriendRequest.new(user_id: users(:michael).id, friend_id: users(:archer).id)
    @request_rev = FriendRequest.new(user_id: users(:archer).id, friend_id: users(:michael).id)
    @request_other = FriendRequest.new(user_id: users(:michael).id, friend_id: users(:lana).id)
    @request_self = FriendRequest.new(user_id: users(:michael).id, friend_id: users(:michael).id)
  end
  
  test "should be valid" do
    assert @request.valid?
    assert @request_dup.valid?
    assert @request_rev.valid?
    assert @request_other.valid?
  end
  
  test "should be invalid need a user_id" do
    @request.user_id = nil
    assert_not @request.valid?
  end
  
  test "should be invalid need a friend_id" do
    @request.friend_id = nil
    assert_not @request.valid?
  end
  
  test "should not have duplicate requests" do
    @request.save
    assert_not @request_dup.valid?
    assert_not @request_rev.valid?
    assert @request_other.valid?
  end

  test "should not request self" do
    assert_not @request_self.valid?
  end

  test "should not request for existing friends" do
    @request.save
    @request.reload
    @request.accept
    assert_not @request_dup.valid?
    assert_not @request_rev.valid?
    assert @request_other.valid?
  end  
end
