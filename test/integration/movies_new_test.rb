# frozen_string_literal: true

require 'test_helper'

class MoviesNewTest < ActionDispatch::IntegrationTest
  def setup
    @movie = Movie.new(title: 'brand new movie', year: 2017, tmdb_id: 1, imdb_id: "itata", tmdb_poster_path: "/example.jpg")
  end

  test 'should not create with out login' do
    assert_no_difference 'Movie.count' do
      post movies_path, params: { movie: { title: @movie.title, year: @movie.year } }
    end
    assert_redirected_to login_path
  end

  test 'should create' do
    log_in_as(users(:michael))
    assert_difference 'Movie.count', +1 do
      post movies_path, params: { movie: { title: @movie.title, 
                                           year: @movie.year,
                                           tmdb_id: @movie.tmdb_id,
                                           imdb_id: @movie.imdb_id,
                                           tmdb_poster_path: @movie.tmdb_poster_path } }
    end
    assert_redirected_to movies_path
    assert_not flash.empty?
  end
  
  test 'should handle failure to create' do
    log_in_as(users(:michael))
    assert_no_difference 'Movie.count' do
      post movies_path, params: { movie: { title: "      ", year: @movie.year } }
    end
    assert flash.empty?
    assert_template 'movies/new'
  end
end