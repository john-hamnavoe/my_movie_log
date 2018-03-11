class FriendWatchesController < ApplicationController
  def index
    @watches = Watch.eager_load(user: :friendships).where('friendships.friend_id = ?', 
      current_user.id).details.paginate(page: params[:page])
  end
end
