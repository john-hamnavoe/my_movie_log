require 'test_helper'

class SubscriptionPaymentsEditTest < ActionDispatch::IntegrationTest
  def setup
    @subscription_payment = subscription_payments(:one)
    @user_michael = users(:michael)
    @user_archer = users(:archer)    
  end
  
  test "should not update without login" do
    assert_no_difference 'SubscriptionPayment.count' do
      patch subscription_payment_path(@subscription_payment), params: { 
        subscription_payment: { amount: 2.99, full_price_amount: 1.99 } }
    end
    assert_redirected_to login_path    
  end
  

  test "should update with login" do
    amount = 2.83
    full_price_amount = 1.44
    log_in_as(@user_michael)
    assert_no_difference 'Subscription.count' do
      patch subscription_payment_path(@subscription_payment), params: { 
        subscription_payment: { amount: amount, full_price_amount: full_price_amount } }
    end
    assert_not flash.empty?
    assert_redirected_to subscription_path
    @subscription_payment.reload
    assert_equal amount, @subscription_payment.amount
    assert_equal full_price_amount, @subscription_payment.full_price_amount
  end  
  
  test "should update only update amount" do
    amount = 2.83
    full_price_amount = 1.44
    no_update_date = '1/1/2010'
    log_in_as(@user_michael)
    assert_no_difference 'Subscription.count' do
      patch subscription_payment_path(@subscription_payment), params: { subscription_payment: { amount: amount,
      start_date: no_update_date, end_date: no_update_date, full_price_amount: full_price_amount } }
    end
    assert_not flash.empty?
    assert_redirected_to subscription_path
    @subscription_payment.reload
    assert_equal amount, @subscription_payment.amount
    assert_equal full_price_amount, @subscription_payment.full_price_amount
    assert_not_equal no_update_date, @subscription_payment.start_date
    assert_not_equal no_update_date, @subscription_payment.end_date
  end  
  
  test "should not update wrong user" do
    amount = 2.83
    old_amount = @subscription_payment.amount
    full_price_amount = 1.44
    old_full_price_amount = @subscription_payment.full_price_amount
    log_in_as(@user_archer)
    assert_no_difference 'Subscription.count' do
      patch subscription_payment_path(@subscription_payment), params: { 
        subscription_payment: { amount: amount, full_price_amount: full_price_amount } }
    end
    assert_redirected_to subscriptions_path
    @subscription_payment.reload
    assert_equal old_amount, @subscription_payment.amount
    assert_equal old_full_price_amount, @subscription_payment.full_price_amount
  end   
end
