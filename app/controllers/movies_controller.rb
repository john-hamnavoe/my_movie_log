# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :logged_in_user, except: [:show, :index]

  def index
    if params[:keywords].present?
      @movies = search_movies
      @keywords = params[:keywords]
    else
      @movies = Movie.all.order(:title).paginate(page: params[:page])
    end
  end

  def show
    id = params[:id]
    @movie = Movie.find_by(id: id)
    @average_rating = Movie.average_rating(id)
    @total_watches = Movie.total_watches(id)
    @last_reviews = Movie.last_reviews(id, 3)
    @user_watches = Watch.details.where(user_id: current_user.id, movie_id: id) if logged_in?
    @watched_redirect = params[:watched].present?
  end

  def create
    @movie = Movie.new(movie_params)
    save_movie
  end

  def create_from_tmdb
    if params[:tmdb_id].present?
      @movie = MovieImporter.import(params[:tmdb_id])
      if params[:redirect_show] == 'true'
        flash[:success] = 'movie refreshed'
        redirect_to @movie
      else
        flash[:success] = 'movie added'
        redirect_to movies_path
      end
    else
      redirect_to movies_path
    end
  end

  def edit
    @movie = Movie.find_by(id: params[:id])
    @upcoming = params[:upcoming]
  end

  def update
    @movie = Movie.find_by(id: params[:id])
    if @movie.update_attributes(movie_params)
      flash[:success] = 'movie updated'
      if params[:movie][:upcoming] == "true" 
        redirect_to upcoming_movies_path
      else
        redirect_to movies_path
      end
    else
      render 'edit'
    end
  end

  def new
    @movie = Movie.new

    if params[:tmdb_id].present?
      set_movie_defaults(params[:tmdb_id])
    end
  end

  def release
    @movie = Movie.find_by(id: params[:id])
    @movie.released = true
    if @movie.save 
      flash[:success] = 'movie release status updated'
    else
      flash[:danager] = @movie.errors.full_messages
    end
    redirect_to upcoming_movies_path
  end

  private

    def movie_params
      params.require(:movie).permit(:title, :year, :imdb_id, :tmdb_id, :tmdb_poster_path,
        :released, :release_date)
    end

    def movie_service
      @movie_service ||= MovieDbService.new
    end

    def set_movie_defaults(tmdb_id)
      movie = movie_service.movie(params[:tmdb_id])
      @movie.title = movie['title']
      @movie.year = year_for_movie(movie)
      @movie.tmdb_id = tmdb_id
      @movie.imdb_id = movie['imdb_id']
      @movie.tmdb_poster_path = movie['poster_path']
    end

    def save_movie
      if @movie.save
        flash[:success] = 'movie created'
        redirect_to movies_path
      else
        render 'new'
      end
    end

    def search_movies
      Movie.where('lower(title) LIKE :keyword',
        keyword: '%' + params[:keywords].downcase + '%').order(:title).paginate(
          page: params[:page])
    end
end
