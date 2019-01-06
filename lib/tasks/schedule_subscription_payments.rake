desc "This task runs daily to create subscription payments required."
task :subscription_payment_run => :environment do
  puts "Running payments..."
  s = SubscriptionPaymentRunService.new
  s.perform
  puts "done. Created #{s.subscription_payments.count} payments."
end