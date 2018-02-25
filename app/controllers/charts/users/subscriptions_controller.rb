# frozen_string_literal: true

class Charts::Users::SubscriptionsController < ApplicationController
  def watch
    subscriptions = Subscription.where(user_id: current_user.id)
    render json: subscriptions.map { |sub| { name: sub.name, data: sub.watches.group_by_month(:date).count } } 
  end
end