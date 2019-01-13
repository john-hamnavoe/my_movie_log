# frozen_string_literal: true

class SubscriptionPaymentRunService
  attr_reader :subscriptions_due, :subscription_payments

  def initialize
    @subscriptions_due = []
    @subscription_payments = []
  end

  def perform
    initialize_payments
    calculate_payments
    save_payments
  end

  private
    def initialize_payments
      @subscriptions_due = Subscription.subscriptions_due
      @subscription_payments = []
    end

    def calculate_payments
      @subscriptions_due.each do |sub|
        current_date = sub.next_due_date || sub.start_date
        sub.next_due_date = NextDueDateUtil.next_due_date(
          current_date, sub.start_date, sub.subscription_period.months)
        subscription_payment = SubscriptionPayment.new(subscription_id: sub.id,
          amount: sub.amount, full_price_amount: sub.full_price_amount, start_date: current_date,
          end_date: sub.next_due_date.advance(days: -1))
        @subscription_payments.push(subscription_payment)
      end
    end

    def save_payments
      Subscription.transaction do
        @subscriptions_due.each do |sub|
          sub.save!
        end
        @subscription_payments.each do |sub_pay|
          sub_pay.save!
        end
      end
    end
end
