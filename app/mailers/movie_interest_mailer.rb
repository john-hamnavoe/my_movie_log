class MovieInterestMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.movie_interest.upcoming_movie.subject
  #
  def upcoming_movie(movie_interest)
    @user = User.find_by(id: movie_interest.user_id)
    @movie = Movie.find_by(id: movie_interest.movie_id)
    mail to: @user.email, subject: 'A movie you are interested in is released soon!'
  end  
end
