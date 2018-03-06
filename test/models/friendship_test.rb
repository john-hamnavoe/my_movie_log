require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @friends = Friendship.new(user_id: users(:michael).id, friend_id: users(:archer).id)
    @friends_dup = Friendship.new(user_id: users(:michael).id, friend_id: users(:archer).id)
    @friends_rev = Friendship.new(user_id: users(:archer).id, friend_id: users(:michael).id)
    @friends_other = Friendship.new(user_id: users(:michael).id, friend_id: users(:lana).id)
    @friends_self = Friendship.new(user_id: users(:michael).id, friend_id: users(:michael).id)
  end
  
  test "should be valid" do
    assert @friends.valid?
    assert @friends_dup.valid?
    assert @friends_rev.valid?
    assert @friends_other.valid?
  end

  test "should have user id" do
    @friends.user_id = nil
    assert_not @friends.valid?
  end

  test "should have friend id" do
    @friends.friend_id = nil
    assert_not @friends.valid?
  end  
  
  test "should have one friendship" do
    @friends.save
    assert_not @friends_dup.valid?
    assert_not @friends_rev.valid?
    assert @friends_other.valid?
  end
  
  test "should not be friends with self" do
    assert_not @friends_self.valid?
  end

  test "should create the inverse relationship" do
    assert_difference 'Friendship.count', +2 do
      @friends.save
    end
    user_michael = Friendship.find_by(user_id: users(:michael).id)
    user_archer = Friendship.find_by(user_id: users(:archer).id)
  
    assert_not user_michael.nil?
    assert_not user_archer.nil?
    assert_equal user_michael.friend_id, user_archer.user_id
    assert_equal user_archer.friend_id, user_michael.user_id
  end
end
