module TmdbMoviesHelper
  
# Returns the poster for the given movie.
def poster_for(movie, options = { size: 45 })
  size = options[:size]
  poster_path = movie["poster_path"]
  poster_url = "https://image.tmdb.org/t/p/w#{size.to_s}#{poster_path}"
  image_tag(poster_url, alt: movie["title"])
end  

def year_for_movie(movie)
  movie["release_date"].to_date.year
end
end
