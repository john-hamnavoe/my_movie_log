class SubscriptionWatchesController < ApplicationController
  before_action :logged_in_user

  def index
    @subscription_id = params[:subscription_id]
    @subscription_watches = Watch.details.where(
      subscription_id: @subscription_id).order(:date).paginate(page: params[:page],
      per_page: 100)
  end
end
