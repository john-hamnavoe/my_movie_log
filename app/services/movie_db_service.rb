class MovieDbService
  attr_reader :configuration

  def initialize
    @configuration = Tmdb::Configuration.new
    @tmdb = Tmdb::Movie
  end

  def popular
    @tmdb.popular.as_json
  end

  def find(keyword)
    @tmdb.find(keyword).as_json if keyword
  end
  
  def movie(id)
    @tmdb.detail(id).as_json if id
  end
end
