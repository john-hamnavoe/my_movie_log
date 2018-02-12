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
  end

  private

    def movie_params
      params.require(:movie).permit(:title, :year, :imdb_id, :tmdb_id, :tmdb_poster_path)
    end
end
