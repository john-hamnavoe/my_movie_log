# frozen_string_literal: true

class WatchLikesController < ApplicationController
  before_action :logged_in_user

  def create
    @watch_like = WatchLike.new(watch_id: params[:watch_id], friend_id: current_user.id)

    if @watch_like.save
      redirect_to friend_feed_path
    else
      flash[:danger] = @watch_like.errors.full_messages
      redirect_to friend_feed_path
    end
  end

  def destroy
    @watch_like = WatchLike.find_by(id: params[:id], friend_id: current_user.id)
    @watch_like.destroy if @watch_like
    redirect_to friend_feed_path
  end
end
