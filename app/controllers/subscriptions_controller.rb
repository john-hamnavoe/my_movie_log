# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @subscriptions = Subscription.all.where(user_id: current_user.id).order(:name)
  end

  def show
    subscription
  end

  def edit
    subscription
  end

  def update
  end

  def new
    @subscription = Subscription.new
  end

  def create
  end

  private

    def subscription
      @subscription = Subscription.find_by(user_id: current_user.id, id: params[:id])
      redirect_to subscriptions_path if @subscription.nil?
    end
end
