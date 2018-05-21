# frozen_string_literal: true

module TmdbMoviesHelper
  # Returns the poster for the given movie.
  def poster_for_movie(movie, options = { size: 45 })
    poster_path = movie['poster_path']
    poster_for_path(poster_path, movie['title'], options)
  end

  def poster_for_path(poster_path, alt, options = { size: 45, display_height: nil })
    size = options[:size]
    display_height = options[:display_height]
    poster_url = "https://image.tmdb.org/t/p/w#{size.to_s}#{poster_path}"
    if poster_path.blank?
      '<i class="fa fa-film fa-3x"></i>'.html_safe
    else
      image_tag(poster_url, alt: alt, height: display_height)
    end
  end

  def year_for_movie(movie)
    begin
      movie['release_date'].to_date.year
    rescue
      nil
    end
  end
end
