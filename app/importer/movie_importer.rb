class MovieImporter
  def self.import(tmdb_id)
    movie_service ||= MovieDbService.new
    tmdb = movie_service.movie(tmdb_id)
    
    movie = Movie.where(tmdb_id: tmdb_id).first_or_initialize
    
    movie.imdb_id = tmdb['imdb_id']

    movie.title    = tmdb['title']
    movie.tagline  = tmdb['tagline']
    movie.overview = tmdb['overview']

    movie.tmdb_poster_path   = tmdb['poster_path']
    movie.backdrop_path = tmdb['backdrop_path']
    
    movie.year = tmdb['release_date'].to_date.year
    
    movie.release_date = tmdb['release_date'].to_date
    
    movie.released = tmdb['release_date'].to_date <= Date.today

    movie.save!

    movie
  end
end