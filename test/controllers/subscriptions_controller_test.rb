require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_michael = users(:michael)
    @user_archer = users(:archer)
    @sub_michael = subscriptions(:one)
    @sub_archer = subscriptions(:three)
  end
  
  test "should redirect index" do
    get subscriptions_path
    assert_redirected_to login_path
    log_in_as(@user_michael)
    get subscriptions_path
    assert :success
  end 
  
  test "index should return for current_user" do
    log_in_as(@user_michael)
    get subscriptions_path
    assert :success    
    subscriptions = assigns(:subscriptions)
    assert_equal 2, subscriptions.count
    assert_not subscriptions.any? { |s| s.user_id != @user_michael.id }
    #eager load test so not N+1 if access these lookups
    assert subscriptions[0].association(:subscription_period).loaded?
    assert subscriptions[0].association(:payment_type).loaded?
    log_in_as(@user_archer)
    get subscriptions_path
    assert :success    
    subscriptions = assigns(:subscriptions)
    assert_equal 1, subscriptions.count
    assert_not subscriptions.any? { |s| s.user_id != @user_archer.id }   
  end

  test "should redirect show" do
    get subscription_path @sub_michael.id
    assert_redirected_to login_path
    log_in_as(@user_michael)
    get subscription_path @sub_michael.id
    assert :success  
    subscription = assigns(:subscription)
    assert_not subscription.nil?
    subscription_payments = assigns(:subscription_payments)
    assert_not subscription_payments.nil?    
    total_watches = assigns(:total_watches)
    assert_not total_watches.nil?   
    total_subs = assigns(:total_subs)
    assert_not total_subs.nil?   
    total_full_price = assigns(:total_full_price)
    assert_not total_full_price.nil?   
    watch_by_years = assigns(:watch_by_years)
    assert_not watch_by_years.nil?       
  end

  test "show redirect if invalid request" do
    log_in_as(@user_michael)
    get subscription_path @sub_archer.id
    assert_redirected_to subscriptions_path
  end
  
  test "should redirect edit" do
    get edit_subscription_path @sub_michael.id
    assert_redirected_to login_path
    log_in_as(@user_michael)
    get edit_subscription_path @sub_michael.id
    assert :success  
    subscription = assigns(:subscription)
    assert_not subscription.nil?
  end

  test "edit redirect if invalid request" do
    log_in_as(@user_michael)
    get edit_subscription_path @sub_archer.id
    assert_redirected_to subscriptions_path
  end 
  
  test "should redirect new" do
    get new_subscription_path
    assert_redirected_to login_path
    log_in_as(@user_michael)
    get new_subscription_path
    assert :success  
    subscription = assigns(:subscription)
    assert_not subscription.nil?
  end  
end
