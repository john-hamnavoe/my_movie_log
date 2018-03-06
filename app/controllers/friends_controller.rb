# frozen_string_literal: true

class FriendsController < ApplicationController
  before_action :logged_in_user  
  
  def destroy
    @friend = current_user.friends.find_by(id: params[:id])
    current_user.remove_friend(@friend) if @friend
    redirect_to users_path
  end
end
