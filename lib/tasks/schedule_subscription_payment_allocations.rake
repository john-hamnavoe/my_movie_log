desc "This task runs daily to create subscription payments required."
task :subscription_payment_allocation => :environment do
  puts "Running allocations..."
  s = SubscriptionPaymentAllocationService.new
  s.perform
  puts "done. Allocated #{s.updated_count} payments to watches."
end
