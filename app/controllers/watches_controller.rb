# frozen_string_literal: true

class WatchesController < ApplicationController
  before_action :logged_in_user

  def index
    @watches = Watch.eager_load(:watch_likes).where(user_id:
      current_user.id).details.paginate(page: params[:page])
  end

  def show
  end

  def new
    if params[:movie_id].present? || params[:tv_show_season_id].present?
      @watch = Watch.new(movie_id: params[:movie_id], tv_show_season_id: params[:tv_show_season_id])
      find_title_and_subscriptions(@watch.movie_id, @watch.tv_show_season_id)
    else
      flash[:info] = 'please select the movie or season you watched'
      redirect_to movies_path
    end
  end

  def create
    @watch = Watch.new(watch_params)
    @watch.user_id = current_user.id
    if @watch.save
      update_subscription_payments
      flash[:success] = 'movie watch added'
      redirect_to_item
    else
      find_title_and_subscriptions(@watch.movie_id, @watch.tv_show_season_id)
      render 'new'
    end
  end

  def edit
    @watch = Watch.find_by(id: params[:id], user_id: current_user.id)
    redirect_to watches_path and return if @watch.nil?
    find_title_and_subscriptions(@watch.movie_id, @watch.tv_show_season_id)
  end

  def update
    @watch = Watch.find_by(id: params[:id], user_id: current_user.id)
    redirect_to watches_path and return if @watch.nil?
    if @watch.update_attributes(watch_params)
      update_subscription_payments
      flash[:success] = 'watch updated'
      redirect_to_item
    else
      find_title_and_subscriptions(@watch.movie_id, @watch.tv_show_season_id)
      render 'edit'
    end
  end

  def destroy
    @watch = Watch.find_by(id: params[:id], user_id: current_user.id)
    redirect_to watches_path and return if @watch.nil?
    @watch.destroy
    flash[:success] = 'watch deleted'
    redirect_to watches_path
  end

  def friends
    @friends = User.joins(:watch_likes).where('watch_likes.watch_id = ?', params[:watch_id])
    respond_to do |format|
      format.html
      format.js
    end    
  end

  private

  def watch_params
    params.require(:watch).permit(:movie_id, :rating, :date, :review, :location_id,
      :subscription_id, :paid, :tv_show_season_id)
  end

  def find_title_and_subscriptions(movie_id, tv_show_season_id)
    @title = Movie.find_by(id: movie_id).title if movie_id.present?
    tv_show_season = TvShowSeason.includes(:tv_show).find_by(id: tv_show_season_id) if tv_show_season_id.present?
    @title = "#{tv_show_season.tv_show.name}-#{tv_show_season.name}" if tv_show_season.present?
    @subscriptions = Subscription.subscriptions_for_user(current_user.id)
  end

  def update_subscription_payments
    SubscriptionPaymentAllocationService.new(watch_id: @watch.id).perform
  end

  def redirect_to_item
    redirect_to movie_path(@watch.movie_id) if @watch.movie_id
    redirect_to tv_show_path(TvShowSeason.find_by(id: @watch.tv_show_season_id).tv_show_id) if @watch.tv_show_season_id
  end
end
