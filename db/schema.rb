# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200112121407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "friend_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friend_requests_on_friend_id"
    t.index ["user_id"], name: "index_friend_requests_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "location_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["name"], name: "index_location_types_on_name", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "location_type_id"
    t.string "website"
    t.string "post_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_type_id"], name: "index_locations_on_location_type_id"
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "movie_favourites", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_favourites_on_movie_id"
    t.index ["user_id"], name: "index_movie_favourites_on_user_id"
  end

  create_table "movie_interests", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_interests_on_movie_id"
    t.index ["user_id"], name: "index_movie_interests_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "tmdb_id"
    t.integer "year"
    t.string "imdb_id"
    t.string "tmdb_poster_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "released", default: true
    t.date "release_date"
    t.string "tagline"
    t.string "overview"
    t.string "backdrop_path"
    t.index "lower((title)::text) gin_trgm_ops", name: "index_lower_title_on_movies", using: :gin
    t.index ["imdb_id"], name: "index_movies_on_imdb_id", unique: true
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
  end

  create_table "payment_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_payment_types_on_name", unique: true
  end

  create_table "subscription_payments", force: :cascade do |t|
    t.integer "subscription_id"
    t.decimal "amount", precision: 5, scale: 2
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "watches_count"
    t.decimal "full_price_amount", precision: 5, scale: 2
    t.index ["subscription_id"], name: "index_subscription_payments_on_subscription_id"
  end

  create_table "subscription_periods", force: :cascade do |t|
    t.string "name"
    t.integer "months"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subscription_periods_on_name", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.date "start_date"
    t.decimal "amount", precision: 5, scale: 2
    t.integer "subscription_period_id"
    t.date "end_date"
    t.integer "payment_type_id"
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "next_due_date"
    t.decimal "full_price_amount", precision: 5, scale: 2
    t.index ["payment_type_id"], name: "index_subscriptions_on_payment_type_id"
    t.index ["subscription_period_id"], name: "index_subscriptions_on_subscription_period_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "watch_likes", force: :cascade do |t|
    t.bigint "watch_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_watch_likes_on_friend_id"
    t.index ["watch_id", "friend_id"], name: "index_watch_likes_on_watch_id_and_friend_id", unique: true
    t.index ["watch_id"], name: "index_watch_likes_on_watch_id"
  end

  create_table "watches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.date "date"
    t.integer "rating"
    t.text "review"
    t.integer "location_id"
    t.integer "subscription_id"
    t.decimal "paid", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subscription_payment_id"
    t.index ["location_id"], name: "index_watches_on_location_id"
    t.index ["movie_id"], name: "index_watches_on_movie_id"
    t.index ["subscription_id"], name: "index_watches_on_subscription_id"
    t.index ["subscription_payment_id"], name: "index_watches_on_subscription_payment_id"
    t.index ["user_id"], name: "index_watches_on_user_id"
  end

  add_foreign_key "friend_requests", "users"
  add_foreign_key "friend_requests", "users", column: "friend_id"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "movie_favourites", "movies"
  add_foreign_key "movie_favourites", "users"
  add_foreign_key "movie_interests", "movies"
  add_foreign_key "movie_interests", "users"
  add_foreign_key "watch_likes", "users", column: "friend_id"
  add_foreign_key "watch_likes", "watches"
  add_foreign_key "watches", "subscription_payments"
end
