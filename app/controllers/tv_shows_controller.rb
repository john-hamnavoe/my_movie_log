class TvShowsController < ApplicationController
  before_action :logged_in_user, except: [:show, :index]

  def index
    if params[:keywords].present?
      @tv_shows = search_tv_shows
      @keywords = params[:keywords]
    else
      @tv_shows = TvShow.all.order(:name).paginate(page: params[:page])
    end
  end

  def show
    id = params[:id]
    @tv_show = TvShow.find_by(id: id)
    @seasons = @tv_show.tv_show_seasons.order(:number)
   # @average_rating = TvShow.average_rating(id)
   # @total_watches = TvShow.total_watches(id)
   # @last_reviews = TvShow.last_reviews(id, 3)
    @watched_redirect = params[:watched].present?
  end

  def create_from_tmdb
    if params[:tmdb_id].present?
      @tv_show = TvShowImporter.import(params[:tmdb_id])
      if params[:redirect_show] == 'true'
        flash[:success] = 'tv show refreshed'
        redirect_to @tv_show
      else
        flash[:success] = 'tv show added'
        redirect_to tv_shows_path
      end
    else
      redirect_to tv_shows_path
    end
  end

  def edit
    @tv_show = TvShow.find_by(id: params[:id])
    @upcoming = params[:upcoming]
  end

  def update
    @tv_show = TvShow.find_by(id: params[:id])
    if @tv_show.update_attributes(tv_show_params)
      flash[:success] = 'tv_show updated'
      if params[:tv_show][:upcoming] == "true" 
        redirect_to upcoming_tv_shows_path
      else
        redirect_to tv_shows_path
      end
    else
      render 'edit'
    end
  end
  
  def release
    @tv_show = TvShow.find_by(id: params[:id])
    @tv_show.released = true
    if @tv_show.save 
      flash[:success] = 'tv_show release status updated'
    else
      flash[:danager] = @tv_show.errors.full_messages
    end
    redirect_to upcoming_tv_shows_path
  end

  private

    def tv_show_params
      params.require(:tv_show).permit(:name, :tmdb_id, :poster_path,
        :overview, :first_air_date, :last_air_date)
    end

    def tv_show_service
      @tv_show_service ||= TvShowDbService.new
    end

    def search_tv_shows
      TvShow.where('lower(name) LIKE :keyword',
        keyword: '%' + params[:keywords].downcase + '%').order(:name).paginate(
          page: params[:page])
    end
end
