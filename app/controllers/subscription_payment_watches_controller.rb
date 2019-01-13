class SubscriptionPaymentWatchesController < ApplicationController
  before_action :logged_in_user

  def index
    @subscription_payment = SubscriptionPayment.find_by(id: params[:subscription_payment_id])
    @subscription_payment_watches = Watch.joins(:movie).where(
      subscription_payment_id: @subscription_payment.id).order(:date)
  end
end
