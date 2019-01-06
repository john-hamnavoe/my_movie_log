# frozen_string_literal: true

class MovieInterestNotificationService
  attr_reader :notifications_due

  def initialize
    @notifications_due = []
  end

  def perform
    intialize_notifications
    send_notification_emails
  end

  private
    def intialize_notifications
      @notifications_due.clear
      mvis = MovieInterest.joins(:user, :movie).where('movies.release_date <= ? AND movies.released = false', Date.today+7)
      mvis.each do |m|
        @notifications_due.push(m) if (m.movie.release_date-Date.today).to_i == 3
      end
    end  

    def send_notification_emails
      @notifications_due.each do |m|
        MovieInterestMailer.upcoming_movie(m).deliver_now
      end
    end
end