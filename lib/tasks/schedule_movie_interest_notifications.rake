desc "This task runs daily to notify users of any movies they are interested in that are due out soon."
task :movie_interest_notification => :environment do
  puts "Running notifications..."
  m = MovieInterestNotificationService.new
  m.perform
  puts "done. Created #{m.notifications_due.count} notifications."
end
