require 'test_helper'

class SubscriptionsNewTest < ActionDispatch::IntegrationTest
  def setup
    @subscription = Subscription.new(name: "new-subscription-test", start_date: '1/1/2016'.to_date,
      amount: 17.90, subscription_period_id: subscription_periods(:one).id)
    @user_michael = users(:michael)
  end
  
  test "should not create without login" do
    assert_no_difference 'Subscription.count' do
      post subscriptions_path, params: { subscription: { name: @subscription.name, 
        start_date: @subscription.start_date, amount: @subscription.amount, 
        subscription_period_id: @subscription.subscription_period_id } }
    end
    assert_redirected_to login_path    
  end
  
  test "should create with login and set user_id" do
    log_in_as(@user_michael)
    assert_difference 'Subscription.count', +1 do
      post subscriptions_path, params: { subscription: { name: @subscription.name, 
        start_date: @subscription.start_date, amount: @subscription.amount, 
        subscription_period_id: @subscription.subscription_period_id } }
    end
    assert_redirected_to subscriptions_path
    subscription = Subscription.find_by(name: @subscription.name)
    assert_equal subscription.user_id, @user_michael.id
    assert_not flash.empty?
  end  
  
  test "should not create with login and invalid details" do
    log_in_as(@user_michael)
    assert_no_difference 'Subscription.count' do
      post subscriptions_path, params: { subscription: { name: "      ", 
        start_date: @subscription.start_date, amount: @subscription.amount, 
        subscription_period_id: nil } }
    end
    assert_template 'subscriptions/new'
    assert flash.empty?
    subscription = assigns(:subscription)
    assert_not subscription.nil?
  end    
end
