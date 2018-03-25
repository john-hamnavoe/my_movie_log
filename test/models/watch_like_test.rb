require 'test_helper'

class WatchLikeTest < ActiveSupport::TestCase
  def setup 
    @watch = watches(:three)
    @friend = users(:lana)
  end

  test "shoud not be valid" do  
    watch_like = WatchLike.new
    assert_not watch_like.valid?
    watch_like.watch_id = @watch.id
    assert_not watch_like.valid?
    watch_like.watch_id = nil
    watch_like.friend_id = @friend.id
    assert_not watch_like.valid?    
  end
  
  test "should be valid" do
    watch_like = WatchLike.new(watch_id: @watch.id, friend_id: @friend.id)
    assert watch_like.valid?
  end
  
  test "should not like same watch" do
    watch_like = WatchLike.new(watch_id: @watch.id, friend_id: @friend.id)
    watch_like.save!
    watch_like_dup = WatchLike.new(watch_id: @watch.id, friend_id: @friend.id) 
    assert_not watch_like_dup.valid?
  end  
end
