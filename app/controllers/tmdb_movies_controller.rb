class TmdbMoviesController < ApplicationController
  
  def index
    if params[:keywords].present? 
      @tmdb_movies = movie_service.find(params[:keywords])
    else
      @tmdb_movies = movie_service.popular
    end
  end

  def show
    @tmdb_movie = movie_service.movie(params[:id])
  end

  private
    def movie_service
      @movie_service ||= MovieDbService.new
    end
end