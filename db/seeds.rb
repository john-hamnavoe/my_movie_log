#SubscriptionPeriod.create!(name: "monthly", months: 1)
#SubscriptionPeriod.create!(name: "annually", months: 12)

#PaymentType.create!(name: "credit card")
#PaymentType.create!(name: "direct debit")
#PaymentType.create!(name: "standing order")

#MovieLocationType.create!(name: "cinema")
#MovieLocationType.create!(name: "subscription service")
#MovieLocationType.create!(name: "free television")
#MovieLocationType.create!(name: "physical media")

movies = Movie.where(tagline: nil)

movies.each do |movie|
    MovieImporter.import(movie.tmdb_id)
    sleep 1
end