# Preview all emails at http://localhost:3000/rails/mailers/movie_interest_mailer
class MovieInterestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/movie_interest_mailer/upcoming_movie
  def upcoming_movie
    movie_interest = MovieInterest.first
    MovieInterestMailer.upcoming_movie movie_interest
  end

end
