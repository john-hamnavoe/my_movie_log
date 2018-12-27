class MovieInterestsController < ApplicationController
  before_action :logged_in_user

  def create
    @movie_interest = MovieInterest.new(movie_id: params[:movie_id], user_id: current_user.id)

    if @movie_interest.save
      respond_to_interest
    else
      flash[:danger] = @movie_interest.errors.full_messages
      respond_to_interest
    end
  end

  def destroy
    @movie_interest = MovieInterest.find_by(id: params[:id], user_id: current_user.id)
    @movie_id = @movie_interest.movie_id if @movie_interest
    @movie_interest.destroy if @movie_interest
    respond_to_interest
  end

  private
  
  def respond_to_interest
    respond_to do |format|
      format.html { redirect_to upcoming_movies_path }
      format.js
    end
  end
end
