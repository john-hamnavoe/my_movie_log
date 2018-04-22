# frozen_string_literal: true

class SubscriptionPaymentAllocationService
  attr_reader :updated_count
  attr_accessor :watch_id

  def initialize(params = {})  
    @watches = []
    @updated_count = 0
    @watch_id = params.fetch(:watch_id, nil)
  end

  def perform
    intialize_watches
    allocate_payments_to_watches
  end  
  
  private
  
    def intialize_watches 
      if @watch_id.nil?  
        @watches = Watch.no_payments
      else
        @watches = Watch.where(id: @watch_id)
      end
    end

    def allocate_payments_to_watches 
      @watches.each do |watch|
        subscription_payment_id = find_subscription_payment(watch)
        watch.update(subscription_payment_id: subscription_payment_id)
        @updated_count += 1 if subscription_payment_id
      end
    end

    def find_subscription_payment(watch)
      payments = SubscriptionPayment.where('start_date <= ? AND end_date >=  ?', 
        watch.date, watch.date).where(subscription_id: watch.subscription_id)
        
      payments[0].id if payments.length == 1 
    end
end
