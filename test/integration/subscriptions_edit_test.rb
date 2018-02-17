require 'test_helper'

class SubscriptionsEditTest < ActionDispatch::IntegrationTest
  def setup
    @subscription = subscriptions(:one)
    @user_michael = users(:michael)
    @user_archer = users(:archer)
  end
  
  test "should not update without login" do
    assert_no_difference 'Subscription.count' do
      patch subscription_path(@subscription), params: { subscription: { name: "new name", 
        start_date: @subscription.start_date, amount: @subscription.amount, 
        subscription_period_id: @subscription.subscription_period_id } }
    end
    assert_redirected_to login_path    
  end
  
  test "should update with login" do
    name = "this is new name"
    amount = 17.80
    log_in_as(@user_michael)
    assert_no_difference 'Subscription.count' do
      patch subscription_path(@subscription), params: { subscription: { name: name, 
        start_date: @subscription.start_date, amount: amount, 
        subscription_period_id: @subscription.subscription_period_id } }
    end
    assert_not flash.empty?
    assert_redirected_to subscriptions_path
    @subscription.reload
    assert_equal name, @subscription.name
    assert_equal amount, @subscription.amount
  end  
  
  test "should not update with login and invalid details" do
    name = "      "
    amount = -17.80
    log_in_as(@user_michael)
    assert_no_difference 'Subscription.count' do
      patch subscription_path(@subscription), params: { subscription: { name: name, 
        start_date: @subscription.start_date, amount: amount, 
        subscription_period_id: @subscription.subscription_period_id } }
    end
    assert_template 'subscriptions/edit'
    assert flash.empty?
    @subscription.reload
    assert_not_equal name, @subscription.name
    assert_not_equal amount, @subscription.amount
  end    
  
  test "should not update with wrong login" do
    name = "this is new name"
    amount = 17.80
    log_in_as(@user_archer)
    assert_no_difference 'Subscription.count' do
      patch subscription_path(@subscription), params: { subscription: { name: name, 
        start_date: @subscription.start_date, amount: amount, 
        subscription_period_id: @subscription.subscription_period_id } }
    end
    assert_redirected_to subscriptions_path
    @subscription.reload
    assert_not_equal name, @subscription.name
    assert_not_equal amount, @subscription.amount
    assert flash.empty?
  end   
end
