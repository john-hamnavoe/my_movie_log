require 'test_helper'

class LookUpServiceTest < ActionView::TestCase
  test "should return nil if invalid name" do
    l = LookUpService.lookup_values(:subscription_periods_junk)
    assert l.nil?
  end  
  
  test "test should return payment types" do
    l = LookUpService.lookup_values(:payment_types)
    assert_equal 3, l.count
    assert_equal 'credit card', l[0].name
  end
  
  test "test should return subscription periods" do
    l = LookUpService.lookup_values(:subscription_periods)
    assert_equal 2, l.count
    assert_equal 'annually', l[0].name
  end  
  
  test "test should return movie location types" do
    l = LookUpService.lookup_values(:movie_location_types)
    assert_equal 4, l.count
    assert_equal 'cinema', l[0].name
    assert_equal 'subscription service', l[3].name
  end    
end