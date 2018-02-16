# frozen_string_literal: true

class TmdbMoviesController < ApplicationController
  def index
    if params[:keywords].present?
      search_result = search_movies
      paginate(search_result[:page], search_result[:total_results],
        search_result[:results])
    else
      paginate(1, movie_service.page_size, movie_service.popular)
    end
  end

  def show
    @tmdb_movie = movie_service.movie(params[:id])
  end

  private

    def movie_service
      @movie_service ||= MovieDbService.new
    end

    def search_movies
      @keywords = params[:keywords]
      page = params[:page] || 1
      movie_service.find(params[:keywords], page: page)
    end

    def paginate(page, total_results, results)
       @tmdb_movies = WillPaginate::Collection.create(page,
        movie_service.page_size, total_results) do |pager|
          pager.replace(results)
       end
    end
end
