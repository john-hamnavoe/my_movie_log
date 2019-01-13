class SubscriptionPaymentsController < ApplicationController
  before_action :logged_in_user

  def edit
    find_subscription_payment
    redirect_to subscriptions_path and return if @subscription_payment.nil?
  end

  def update
    find_subscription_payment
    redirect_to subscriptions_path and return if @subscription_payment.nil?
    if @subscription_payment.update_attributes(subscription_payment_params)
      flash[:success] = 'subscription payment updated'
      redirect_to subscription_path(@subscription_payment.subscription_id)
    else
      render 'edit'
    end    
  end

  private

    def find_subscription_payment
      @subscription_payment = SubscriptionPayment.find_by(id: params[:id])
      if Subscription.find_by(user_id: current_user.id, id: @subscription_payment.subscription_id).nil?
        @subscription_payment = nil
      end
    end

    def subscription_payment_params
      params.require(:subscription_payment).permit(:amount, :full_price_amount)
    end
end
