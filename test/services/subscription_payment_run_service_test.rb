require 'test_helper'

class SubscriptionPaymentRunServiceTest < ActionView::TestCase
  def setup
    # run before every test - fixtures could create data    
    s = SubscriptionPaymentRunService.new
    s.perform
  end
  
  test "create monthly subscription_payment" do
    create_monthly_subscription_payment_success(nil, "no end date")
  end

  test "create monthly subscription_payment valid end date" do
    create_monthly_subscription_payment_success(Date::today, "end date today")
  end
  
  test "create annual subscription_payment" do
    subscription_anual_due = Subscription.new(name: "unlimited", start_date: '1/1/2018',
      amount: 79.00, subscription_period_id: subscription_periods(:two).id, 
      user_id: users(:michael).id, full_price_amount: 11.14)     
    subscription_anual_due.save!
    s = SubscriptionPaymentRunService.new
    assert_difference 'SubscriptionPayment.count', +1 do
      s.perform
    end
    subscription_anual_due.reload
    assert_equal '1/1/2019'.to_date, subscription_anual_due.next_due_date
    subscription_payment = SubscriptionPayment.find_by(subscription_id: subscription_anual_due.id)
    assert_equal subscription_anual_due.amount, subscription_payment.amount
    assert_equal '1/1/2018'.to_date, subscription_payment.start_date
    assert_equal '31/12/2018'.to_date, subscription_payment.end_date
    assert_equal subscription_anual_due.full_price_amount, subscription_payment.full_price_amount
  end  
  
  test "do not create payment not due" do
    subscription_monthly_due = Subscription.new(name: "unlimited", start_date: (Date::today).advance(months: -1),
      amount: 17.90, subscription_period_id: subscription_periods(:one).id, 
      user_id: users(:michael).id, next_due_date: (Date::today).advance(days: 1), full_price_amount: 11.70)     
    subscription_monthly_due.save!
    s = SubscriptionPaymentRunService.new
    assert_no_difference 'SubscriptionPayment.count' do
      s.perform
    end
    subscription_monthly_due.reload
    assert_equal (Date::today).advance(days: 1), subscription_monthly_due.next_due_date
  end 
  
  test "create payment due today" do
    subscription_monthly_due = Subscription.new(name: "unlimited", start_date: (Date::today).advance(months: -1),
      amount: 19.98, subscription_period_id: subscription_periods(:one).id, 
      user_id: users(:michael).id, next_due_date: (Date::today), full_price_amount: 11.54)     
    subscription_monthly_due.save!
    s = SubscriptionPaymentRunService.new
    assert_difference 'SubscriptionPayment.count', +1 do
      s.perform
    end
    subscription_monthly_due.reload
    subscription_payment = SubscriptionPayment.find_by(subscription_id: subscription_monthly_due.id)
    assert_equal subscription_monthly_due.amount, subscription_payment.amount    
    assert_equal subscription_monthly_due.next_due_date.advance(days: -1), subscription_payment.end_date 
    assert_equal subscription_monthly_due.full_price_amount, subscription_payment.full_price_amount   
  end   
  
  private 
    def create_monthly_subscription_payment_success(end_date, message)
      subscription_monthly_due = Subscription.new(name: "unlimited", start_date: '1/1/2018',
        amount: 17.90, subscription_period_id: subscription_periods(:one).id, 
        user_id: users(:michael).id, end_date: end_date, full_price_amount: 11.70)     
      subscription_monthly_due.save!
      s = SubscriptionPaymentRunService.new
      assert_difference 'SubscriptionPayment.count', +1, message do
        s.perform
      end
      subscription_monthly_due.reload
      assert_equal '1/2/2018'.to_date, subscription_monthly_due.next_due_date
      subscription_payment = SubscriptionPayment.find_by(subscription_id: subscription_monthly_due.id)
      assert_equal subscription_monthly_due.amount, subscription_payment.amount
      assert_equal '1/1/2018'.to_date, subscription_payment.start_date
      assert_equal '31/1/2018'.to_date, subscription_payment.end_date
      assert_equal subscription_monthly_due.full_price_amount, subscription_payment.full_price_amount
    end
end