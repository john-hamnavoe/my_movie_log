class FriendWatchesController < ApplicationController
  before_action :logged_in_user

  def index
    @watches = Watch.eager_load(user: :friendships).where('friendships.friend_id = ?', 
      current_user.id).details.paginate(page: params[:page])
    @watch_likes = WatchLike.where(friend_id: current_user.id).where(
      watch_id: @watches.pluck(:id))
  end
end
