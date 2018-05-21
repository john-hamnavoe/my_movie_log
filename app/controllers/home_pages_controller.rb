# frozen_string_literal: true

class HomePagesController < ApplicationController
  def home
    @top_10_movies = top_10_movies
    @top_10_movies_last_month = top_10_movies_last_month
    @users_count = User.count
  end

  def contact
  end

  def about
  end

private
  
  def top_10_movies
    query = <<-SQL
      SELECT  COUNT("movies"."id") AS count_id, 
              "movies"."id", 
              "movies"."title", 
              "movies"."imdb_id", 
              "movies"."tmdb_id",
              "movies"."tmdb_poster_path"
      FROM  
              "movies" 
      INNER JOIN 
              "watches" ON "watches"."movie_id" = "movies"."id" 
      GROUP BY 
              "movies"."id", 
              "movies"."title", 
              "movies"."imdb_id", 
              "movies"."tmdb_id",
              "movies"."tmdb_poster_path"
      ORDER BY count_id DESC LIMIT 10 
    SQL
    
    Movie.find_by_sql(query)
  end

  def top_10_movies_last_month
    query = <<-SQL
      SELECT  COUNT("movies"."id") AS count_id, 
              "movies"."id", 
              "movies"."title", 
              "movies"."imdb_id", 
              "movies"."tmdb_id",
              "movies"."tmdb_poster_path"
      FROM  
              "movies" 
      INNER JOIN 
              "watches" ON "watches"."movie_id" = "movies"."id" 
      WHERE
              "watches"."date" >= ?              
      GROUP BY 
              "movies"."id", 
              "movies"."title", 
              "movies"."imdb_id", 
              "movies"."tmdb_id",
              "movies"."tmdb_poster_path"
      ORDER BY count_id DESC LIMIT 10 
    SQL
    
    Movie.find_by_sql([query, Date.today - 1.month])
  end
end
