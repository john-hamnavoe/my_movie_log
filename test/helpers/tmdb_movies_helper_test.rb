require 'test_helper'

class TmdbMoviesHelperTest < ActionView::TestCase

  def setup
    @movie =  { "poster_path"=>"/qEczX5Rruux72XOHDeeLJEvmZkV.jpg", 
                "release_date"=>"2007-01-01",
                "title"=>"title"}
  end

  test "get correct year " do
    year = year_for_movie(@movie)
    assert 2007, year
    @movie["release_date"] = "1962-04-22"
    year = year_for_movie(@movie)
    assert 1962, year
    @movie["release_date"] = ""
    year = year_for_movie(@movie)
    assert year.nil? 
    @movie["release_date"] = nil
    year = year_for_movie(@movie)
    assert year.nil?     
    @movie["release_date"] = "1974-13-13"
    year = year_for_movie(@movie)
    assert year.nil?      
  end
  
  test "get poster_path for movie" do
    poster_path = poster_for_movie(@movie)
    assert_equal "<img alt=\"title\" src=\"https://image.tmdb.org/t/p/w45/qEczX5Rruux72XOHDeeLJEvmZkV.jpg\" />",
      poster_path
    poster_path = poster_for_movie(@movie, size:92)
    assert_equal "<img alt=\"title\" src=\"https://image.tmdb.org/t/p/w92/qEczX5Rruux72XOHDeeLJEvmZkV.jpg\" />",
      poster_path      
    @movie["poster_path"] = nil
    poster_path = poster_for_movie(@movie)
    assert_equal "<i class=\"fa fa-film fa-3x\"></i>", poster_path
    @movie["poster_path"] = "    "
    poster_path = poster_for_movie(@movie)
    assert_equal "<i class=\"fa fa-film fa-3x\"></i>", poster_path    
  end
  
  test "get poster_path for path" do
    poster_path = poster_for_path(@movie["poster_path"], "title")
    assert_equal "<img alt=\"title\" src=\"https://image.tmdb.org/t/p/w45/qEczX5Rruux72XOHDeeLJEvmZkV.jpg\" />",
      poster_path
    poster_path = poster_for_path(@movie["poster_path"], "title", size:92)
    assert_equal "<img alt=\"title\" src=\"https://image.tmdb.org/t/p/w92/qEczX5Rruux72XOHDeeLJEvmZkV.jpg\" />",
      poster_path      
    poster_path = poster_for_path(@movie["poster_path"], "title", size:92, display_height: 52)
    assert_equal "<img alt=\"title\" height=\"52\" src=\"https://image.tmdb.org/t/p/w92/qEczX5Rruux72XOHDeeLJEvmZkV.jpg\" />",
      poster_path        
    poster_path = poster_for_path(nil, "title")
    assert_equal "<i class=\"fa fa-film fa-3x\"></i>", poster_path
    poster_path = poster_for_path("    ", "title")
    assert_equal "<i class=\"fa fa-film fa-3x\"></i>", poster_path    
  end  
end