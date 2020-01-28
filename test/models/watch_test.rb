require 'test_helper'

class WatchTest < ActiveSupport::TestCase
  def setup 
    @watch = Watch.new(user_id: users(:michael).id, movie_id: movies(:movie_one).id, 
      date: '1/1/2018'.to_date)
  end
  
  test "should be valid" do
    assert @watch.valid?
  end
  
  test "should have user" do
    @watch.user_id = nil
    assert_not @watch.valid?
  end
  
  test "should have date" do
    @watch.date = nil
    assert_not @watch.valid?
  end
  
  test "rating between 0 and 5" do
    @watch.rating = -1
    assert_not @watch.valid?
    @watch.rating = 0
    assert @watch.valid?
    @watch.rating = 5
    assert @watch.valid?
    @watch.rating = 6
    assert_not @watch.valid?
  end
end

