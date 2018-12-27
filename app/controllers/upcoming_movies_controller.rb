class UpcomingMoviesController < ApplicationController
  def index
    @upcoming_movies = Movie.where(released: false).order(:release_date, :title).paginate(page: params[:page])

    if logged_in?
      @movie_interests = MovieInterest.where(user_id: current_user.id).where(
        movie_id: @upcoming_movies.pluck(:id)) if @upcoming_movies
    end
  end
end
