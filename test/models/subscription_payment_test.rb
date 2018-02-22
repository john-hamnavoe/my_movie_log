require 'test_helper'

class SubscriptionPaymentTest < ActiveSupport::TestCase
  def setup
    @subscription_payment = SubscriptionPayment.new(subscription_id: subscriptions(:one).id,
      start_date: '1/1/2018'.to_date, end_date: '31/1/2018'.to_date, amount: 17.90)
  end
  
  test "should be valid" do
    assert @subscription_payment.valid?, @subscription_payment.errors.full_messages
  end
  
  test "should require start_date" do
    @subscription_payment.start_date = nil
    assert_not @subscription_payment.valid?
  end
  
  test "should require end_date" do
    @subscription_payment.end_date = nil
    assert_not @subscription_payment.valid?
  end 
  
  test "should require amount" do
    @subscription_payment.amount = nil
    assert_not @subscription_payment.valid?
  end   
  
  test "should have start_date before end date" do
    @subscription_payment.start_date = @subscription_payment.end_date
    assert_not @subscription_payment.valid?, "start date == end_date"
    @subscription_payment.start_date = @subscription_payment.end_date.advance(days: 1)
    assert_not @subscription_payment.valid?, "start date after"
    @subscription_payment.start_date = @subscription_payment.end_date.advance(days: -1)
    assert @subscription_payment.valid?, "start date before #{@subscription_payment.start_date}, #{@subscription_payment.end_date}"      
  end     
end
