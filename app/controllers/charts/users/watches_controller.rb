# frozen_string_literal: true

class Charts::Users::WatchesController < ApplicationController
  def watch
    render json: Watch.where(user_id: current_user.id).group_by_month(:date).count
  end

  def location_cinema
    render json: Watch.joins(:location).where(user_id: current_user.id).where(
      'locations.location_type_id = ?', 1).group('locations.name').count
  end

  def rating
    render json: Watch.where(user_id: current_user.id).where.not(rating: nil).group(
      :rating).order(rating: :asc).count
  end
end
