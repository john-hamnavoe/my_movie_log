require 'test_helper'

class SubscriptionPaymentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @subscription_payment = subscription_payments(:one)
  end
  
  test "should redirect edit if not logged in" do
    get edit_subscription_payment_path(@subscription_payment.id)
    assert_redirected_to login_path
    log_in_as(users(:michael))
    get edit_subscription_payment_path(@subscription_payment.id)
    assert :success
  end
end
