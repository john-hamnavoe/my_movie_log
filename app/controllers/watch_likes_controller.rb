# frozen_string_literal: true

class WatchLikesController < ApplicationController
  before_action :logged_in_user

  def create
    @watch_like = WatchLike.new(watch_id: params[:watch_id], friend_id: current_user.id)

    if @watch_like.save
      respond_to_like
    else
      flash[:danger] = @watch_like.errors.full_messages
      respond_to_like
    end
  end

  def destroy
    @watch_like = WatchLike.find_by(id: params[:id], friend_id: current_user.id)
    @watch_id = @watch_like.watch_id if @watch_like
    @watch_like.destroy if @watch_like
    respond_to_like
  end

  private
  
  def respond_to_like
    respond_to do |format|
      format.html { redirect_to friend_feed_path }
      format.js
    end
  end
end
