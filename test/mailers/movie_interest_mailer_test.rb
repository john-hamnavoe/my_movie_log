require 'test_helper'

class MovieInterestMailerTest < ActionMailer::TestCase

  test "upcoming movie" do
    movie_interest = movie_interests(:one)
    user = User.find_by(id: movie_interest.user_id)
    movie = Movie.find_by(id: movie_interest.movie_id)
    mail = MovieInterestMailer.upcoming_movie (movie_interest)
    assert_equal "A movie you are interested in is released soon!", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match movie.title,                                  mail.body.encoded
    assert_match movie.release_date.strftime("%m/%d/%Y"),      mail.body.encoded
  end
end
