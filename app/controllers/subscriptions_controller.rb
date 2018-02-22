# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :logged_in_user

  def index
    @subscriptions = Subscription.all.where(user_id: current_user.id).order(:name)
  end

  def show
    find_subscription
    redirect_to subscriptions_path and return if @subscription.nil?    
    @subscription_payments = SubscriptionPayment.where(
      subscription_id: @subscription.id).order(start_date: :desc).paginate(
      page: params[:page])
  end

  def edit
    find_subscription
    redirect_to subscriptions_path and return if @subscription.nil?
  end

  def update
    find_subscription
    redirect_to subscriptions_path and return if @subscription.nil?
    if @subscription.update_attributes(subscription_params)
      flash[:success] = 'subscription updated'
      redirect_to subscriptions_path
    else
      render 'edit'
    end
  end

  def new
    @subscription = Subscription.new
  end

  def create
    subscription = Subscription.new(subscription_params)
    subscription.user_id = current_user.id
    if subscription.save
      flash[:success] = 'subscription created'
      redirect_to subscriptions_path
    else
      @subscription = subscription
      render 'new'
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit(:name, :amount, :start_date, :end_date,
        :reference, :subscription_period_id, :payment_type_id)
    end

    def find_subscription
      @subscription = Subscription.find_by(user_id: current_user.id, id: params[:id])
    end
end
