require 'test_helper'

class SubscriptionWatchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @subscription = subscriptions(:one)
  end
  
  test "should get index" do
    get subscription_watches_path(@subscription.id)
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get subscription_watches_path(@subscription.id)
    assert :success
    assert_select "a[href=?]", subscription_path(@subscription.id)
  end

end
