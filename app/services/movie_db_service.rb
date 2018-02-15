class MovieDbService
  attr_reader :configuration, :page_size

  def initialize
    @configuration = Tmdb::Configuration.new
    @tmdb = Tmdb::Movie
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
      tmdb_results = @search.movie(keyword, page: page)
      result[:page] = tmdb_results.page
      result[:total_results] = tmdb_results.total_results
      result[:results] = search_results_as_json(tmdb_results) 
    end
    
    return result
  end
  
  def movie(id)
    movie_as_json(@tmdb.detail(id)) if id
  end

  private
  
    # Open Struct returns {"table"=>{ as part as_json - unelegant way of stripping out
    def search_results_as_json(search_result)
      json_movies = []
      search_result.results.each do |movie|
        json_movie = movie_as_json(movie)
        json_movies.push(json_movie)
      end
      return json_movies
    end
    
    def movie_as_json(movie)
      movie.as_json["table"]
    end
end
