require 'test_helper'

class SubscriptionPaymentWatchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @subscription_payment = subscription_payments(:one)
  end
  
  test "should get index" do
    get subscription_payment_watches_path(@subscription_payment.id)
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get subscription_payment_watches_path(@subscription_payment.id)
    assert :success
    assert_select "a[href=?]", subscription_path(@subscription_payment.subscription_id)
  end

end
