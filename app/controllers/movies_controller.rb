class MoviesController < ApplicationController
  before_action :logged_in_user, except: [:show, :index]
  
  def index
    @movies = Movie.all.order(:title).paginate(page: params[:page])
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path
    else
      render 'new'
    end
  end

  def edit
    @movie = Movie.find_by(id: params[:id])
  end

  def update
    @movie = Movie.find_by(id: params[:id])
    if @movie.update_attributes(movie_params)
      flash[:success] = "movie updated"
      redirect_to movies_path
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

  private

    def movie_params
      params.require(:movie).permit(:title, :year, :imdb_id, :tmdb_id, :tmdb_poster_path)
    end

    def movie_service
      @movie_service ||= MovieDbService.new
    end   

    def set_movie_defaults(tmdb_id)
      movie = movie_service.movie(params[:tmdb_id])
      @movie.title = movie["title"]
      @movie.year = year_for_movie(movie)
      @movie.tmdb_id = tmdb_id
      @movie.imdb_id = movie["imdb_id"]
      @movie.tmdb_poster_path = movie["poster_path"]
    end
end
