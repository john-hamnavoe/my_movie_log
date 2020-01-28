# frozen_string_literal: true

class TvShowDbService
  attr_reader :configuration, :page_size

  def initialize
    @configuration = Tmdb::Configuration.new
    @tmdb = Tmdb::TV
    @search = Tmdb::Search
    @page_size = 20
  end

  def popular
    search_results_as_json(@tmdb.popular)
  end

  def find(keyword, options = { page: 1 })
    page = options[:page]
    result = {}
    if keyword
      tmdb_results = @search.tv(keyword, page: page)
      result[:page] = tmdb_results.page
      result[:total_results] = tmdb_results.total_results
      result[:results] = search_results_as_json(tmdb_results)
    end

    result
  end

  def tv_show(id)
    tv_show_as_json(@tmdb.detail(id)) if id
  end

  private

    # Open Struct returns {"table"=>{ as part as_json - unelegant way of stripping out
    def search_results_as_json(search_result)
      json_tv_shows = []
      search_result.results.each do |tv_show|
        json_tv_show = tv_show_as_json(tv_show)
        json_tv_shows.push(json_tv_show)
      end
      json_tv_shows
    end

    def tv_show_as_json(movie)
      movie.as_json['table']
    end
end
