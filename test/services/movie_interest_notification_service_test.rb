require 'test_helper'

class MovieInterestNotificationServiceTest < ActionView::TestCase

  test "movie interest due for release get notifiction if not released no notification if released" do
    movie_interest = movie_interests(:one)
    set_release_date(movie_interest.movie_id, Date.today+3)
    m = MovieInterestNotificationService.new
    assert_difference('ActionMailer::Base.deliveries.size', 1) do       
      m.perform
    end
    assert_equal m.notifications_due.length, 1
    set_movie_to_released(movie_interest.movie_id)
    assert_no_difference('ActionMailer::Base.deliveries.size') do       
      m.perform
    end
    assert_equal m.notifications_due.length, 0   
  end
  
  test "movie interest due for release not soon enough" do
    movie_interest = movie_interests(:one)
    set_release_date(movie_interest.movie_id, Date.today+4)
    m = MovieInterestNotificationService.new
    assert_no_difference('ActionMailer::Base.deliveries.size') do       
      m.perform
    end
    assert_equal m.notifications_due.length, 0
  end
  
  test "movie interest due for release due too soon" do
    movie_interest = movie_interests(:one)
    set_release_date(movie_interest.movie_id, Date.today+2)
    m = MovieInterestNotificationService.new
    assert_no_difference('ActionMailer::Base.deliveries.size') do       
      m.perform
    end
    assert_equal m.notifications_due.length, 0
  end
  
private
  def set_release_date(movie_id, release_date)
    movie = Movie.find_by(id: movie_id)
    movie.release_date = release_date
    movie.released = false
    movie.save!   
  end
  
  def set_movie_to_released(movie_id)
    movie = Movie.find_by(id: movie_id)
    movie.released = true
    movie.save!   
  end
end