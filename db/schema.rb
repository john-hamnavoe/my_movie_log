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

ActiveRecord::Schema.define(version: 20180218101830) do

  create_table "location_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "tmdb_id"
    t.integer "year"
    t.string "imdb_id"
    t.string "tmdb_poster_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imdb_id"], name: "index_movies_on_imdb_id", unique: true
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
  end

  create_table "payment_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_payment_types_on_name", unique: true
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

end
