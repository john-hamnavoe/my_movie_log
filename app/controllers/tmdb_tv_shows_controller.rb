# frozen_string_literal: true

class TmdbTvShowsController < ApplicationController
  def index
    if params[:keywords].present?
      search_result = search_TvShows
      paginate(search_result[:page], search_result[:total_results],
        search_result[:results])
    else
      paginate(1, tv_show_service.page_size, tv_show_service.popular)
    end
  end

  def show
    @tmdb_tv_show = tv_show_service.tv_show(params[:id])
  end

  private

    def tv_show_service
      @tv_show_service ||= TvShowDbService.new
    end

    def search_TvShows
      @keywords = params[:keywords]
      page = params[:page] || 1
      tv_show_service.find(params[:keywords], page: page)
    end

    def paginate(page, total_results, results)
       @tmdb_tv_shows = WillPaginate::Collection.create(page,
        tv_show_service.page_size, total_results) do |pager|
          pager.replace(results)
       end
    end
end
