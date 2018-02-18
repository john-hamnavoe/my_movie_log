SubscriptionPeriod.create!(name: "monthly", months: 1)
SubscriptionPeriod.create!(name: "annually", months: 12)

PaymentType.create!(name: "credit card")
PaymentType.create!(name: "direct debit")
PaymentType.create!(name: "standing order")

LocationType.create!(name: "cinema")
LocationType.create!(name: "subscription service")
LocationType.create!(name: "free television")
LocationType.create!(name: "physical media")