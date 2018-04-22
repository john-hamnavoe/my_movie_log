desc "This task can be run adhoc to seed the watches_count correctly."
task :subscription_payment_watches_count_seed => :environment do
  puts "Running watches_count seed..."
    SubscriptionPayment.find_each { |payment| SubscriptionPayment.reset_counters(
      payment.id, :watches) }
  puts "done. "
end
