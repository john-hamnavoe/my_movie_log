require 'test_helper'

class SubscriptionPaymentAllocationServiceTest < ActionView::TestCase

  def setup
    @subscription = subscriptions(:one)
    @watch = watches(:one)
    @watch_two = watches(:six)
    @payment_one = subscription_payments(:one)
    @payment_two = subscription_payments(:three)
    @watch.update(subscription_payment_id: nil)
    @watch_two.update(subscription_payment_id: nil)
  end

  test "set subscription payment on watch based on date" do
    assert_nil @watch.subscription_payment_id
    @watch.update(date: @payment_one.start_date)
    payment_one_watches = @payment_one.watches_count || 0
    perform_subscription_payment_update(@watch.id)
    assert_equal @payment_one.id, @watch.subscription_payment_id, "now associated with payment one"
    assert_equal payment_one_watches + 1, @payment_one.watches_count
    
    @watch.update(date: @payment_two.start_date)
    payment_one_watches = @payment_one.watches_count || 0
    payment_two_watches = @payment_two.watches_count || 0
    perform_subscription_payment_update(@watch.id)   
    assert_equal @payment_two.id, @watch.subscription_payment_id, "now associated with payment two"
    assert_equal payment_one_watches - 1, @payment_one.watches_count    
    assert_equal payment_two_watches + 1, @payment_two.watches_count  
    
    @watch.update(date: @payment_one.start_date - 1.months)
    payment_one_watches = @payment_one.watches_count || 0    
    payment_two_watches = @payment_two.watches_count || 0
    perform_subscription_payment_update(@watch.id)   
    assert_nil @watch.subscription_payment_id, "now associated with no payment"
    assert_equal payment_one_watches, @payment_one.watches_count    
    assert_equal payment_two_watches - 1, @payment_two.watches_count      
    
    @watch.update(date: @payment_two.end_date)
    payment_one_watches = @payment_one.watches_count || 0
    payment_two_watches = @payment_two.watches_count || 0
    perform_subscription_payment_update(@watch.id)   
    assert_equal @payment_two.id, @watch.subscription_payment_id, "now associated with payment two"
    assert_equal payment_one_watches, @payment_one.watches_count    
    assert_equal payment_two_watches + 1, @payment_two.watches_count      
  end
  
  test "set batch subscription_payments payment on watch based on date" do
    payment_one_watches = @payment_one.watches_count || 0
    payment_two_watches = @payment_two.watches_count || 0  
    @watch.update(date: @payment_one.end_date)
    @watch_two.update(date: @payment_two.end_date)    
    perform_batch_subscription_payment_update 
    assert_equal @payment_one.id, @watch.subscription_payment_id
    assert_equal @payment_two.id, @watch_two.subscription_payment_id     
    assert_equal payment_one_watches + 1, @payment_one.watches_count    
    assert_equal payment_two_watches + 1, @payment_two.watches_count      
  end

  private
    
    def perform_subscription_payment_update(watch_id)
      SubscriptionPaymentAllocationService.new(watch_id: watch_id).perform
      @watch.reload
      @payment_one.reload
      @payment_two.reload
    end
    
    def perform_batch_subscription_payment_update
      SubscriptionPaymentAllocationService.new.perform
      @watch.reload
      @watch_two.reload
      @payment_one.reload
      @payment_two.reload
    end
end
