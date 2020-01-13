# frozen_string_literal: true

module TmdbMoviesHelper
  # Returns the poster for the given movie.
  def poster_for_movie(movie, options = { size: 45 })
    poster_path = movie['poster_path']
    poster_for_path(poster_path, movie['title'], options)
  end

  def poster_for_path(poster_path, alt, options = { size: 45, display_height: nil, class: nil })
    size = options[:size]
    size = 45 if size.to_s.empty?
    display_height = options[:display_height]
    display_class = options[:class]
    poster_url = "https://image.tmdb.org/t/p/w#{size.to_s}#{poster_path}"
    if poster_path.blank?
      '<i class="fa fa-film fa-3x"></i>'.html_safe
    else
      image_tag(poster_url, alt: alt, height: display_height, class: display_class)
    end
  end
  
  def background_for_path(background_path, alt, options = { version: "original" })
    version = options[:version]
    background_url = "https://image.tmdb.org/t/p/#{version.to_s}#{background_path}"
    if background_path.blank?
      '<i class="fa fa-film fa-3x"></i>'.html_safe
    else
      image_tag(background_url, alt: alt)
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
