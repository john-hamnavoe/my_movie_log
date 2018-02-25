# frozen_string_literal: true

class WatchesController < ApplicationController
  before_action :logged_in_user

  def index
    @watches = Watch.where(user_id: current_user.id).details.paginate(page: params[:page])
  end

  def show
  end

  def new
    if params[:movie_id].present?
      @watch = Watch.new(movie_id: params[:movie_id])
      find_movie_and_subscriptions(@watch.movie_id)
    else
      flash[:info] = 'please select the movie you watched'
      redirect_to movies_path
    end
  end

  def create
    @watch = Watch.new(watch_params)
    @watch.user_id = current_user.id
    if @watch.save
      flash[:success] = 'movie watch added'
      redirect_to movies_path
    else
      find_movie_and_subscriptions(@watch.movie_id)
      render 'new'
    end
  end

  def edit
    @watch = Watch.find_by(id: params[:id], user_id: current_user.id)
    redirect_to watches_path and return if @watch.nil?
    find_movie_and_subscriptions(@watch.movie_id)
  end

  def update
    @watch = Watch.find_by(id: params[:id], user_id: current_user.id)
    redirect_to watches_path and return if @watch.nil?
    if @watch.update_attributes(watch_params)
      flash[:success] = "watch updated"
      redirect_to watches_path
    else
      find_movie_and_subscriptions(@watch.movie_id)
      render 'edit'
    end
  end

  def destroy
    @watch = Watch.find_by(id: params[:id], user_id: current_user.id)
    redirect_to watches_path and return if @watch.nil?
    @watch.destroy
    flash[:success] = "watch deleted"
    redirect_to watches_path
  end

  private

  def watch_params
    params.require(:watch).permit(:movie_id, :rating, :date, :review, :location_id,
      :subscription_id, :paid)
  end
  
  def find_movie_and_subscriptions(movie_id)
    @movie = Movie.find_by(id: movie_id)
    @subscriptions = Subscription.subscriptions_for_user(current_user.id)
  end
end
