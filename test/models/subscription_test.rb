require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  def setup
    @subscription = Subscription.new(name: "unlimited", start_date: '1/1/2016'.to_date,
      amount: 17.90, subscription_period_id: subscription_periods(:one).id, 
      user_id: users(:michael).id)
  end
  
  test "subscription is valid?" do
    assert @subscription.valid?, @subscription.errors.full_messages
  end
  
  test "subscription must have period" do
    @subscription.subscription_period_id = nil
    assert_not @subscription.valid?
  end
  
  test "subscription must have user" do
    @subscription.user_id = nil
    assert_not @subscription.valid?
  end  
  
  test "subscription must have name of no more than 75 characters" do
    @subscription.name = "    "
    assert_not @subscription.valid?
    @subscription.name = "a"*76 
    assert_not @subscription.valid?
    @subscription.name = "a"*75
    assert @subscription.valid?    
  end
  
  test "subscription must have a start_date" do
    @subscription.start_date = nil?
    assert_not @subscription.valid?
  end
  
  test "subscription end_date must be after start_date" do
    @subscription.end_date = '1/2/2016'.to_date
    assert @subscription.valid? 
    @subscription.end_date = '31/12/2015'.to_date
    assert_not @subscription.valid?
  end
end