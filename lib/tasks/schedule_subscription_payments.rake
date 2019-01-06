desc "This task runs daily to create subscription payments required."
task :movie_interest_notification => :environment do
  puts "Running notifications..."
  m = MovieInterestNotificationService.new
  m.perform
  puts "done. Created #{m.notifications_due.count} notifications."
end
