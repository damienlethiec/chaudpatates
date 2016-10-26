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

ActiveRecord::Schema.define(version: 20161026140211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "training_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["training_id"], name: "index_bookings_on_training_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cities_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "state"
    t.string   "ticket_sku"
    t.integer  "amount_cents", default: 0,  null: false
    t.json     "payment"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "tickets_nb",   default: 10
    t.integer  "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "day"
    t.time     "time_of_day"
    t.integer  "city_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["city_id"], name: "index_sessions_on_city_id", using: :btree
  end

  create_table "tickets_packages", force: :cascade do |t|
    t.string   "sku"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "price_cents", default: 0, null: false
    t.integer  "tickets_nb"
  end

  create_table "trainings", force: :cascade do |t|
    t.text     "public_description"
    t.text     "private_description"
    t.datetime "date"
    t.integer  "city_id"
    t.integer  "location_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "session_id"
    t.index ["city_id"], name: "index_trainings_on_city_id", using: :btree
    t.index ["location_id"], name: "index_trainings_on_location_id", using: :btree
    t.index ["session_id"], name: "index_trainings_on_session_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "tickets_nb",             default: 1
    t.boolean  "is_coach",               default: false
    t.boolean  "admin",                  default: false
    t.string   "provider"
    t.string   "uid"
    t.string   "headline"
    t.string   "linkedin_summary"
    t.string   "linkedin_picture_url"
    t.string   "linkedin_profile"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bookings", "trainings"
  add_foreign_key "bookings", "users"
  add_foreign_key "cities", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "sessions", "cities"
  add_foreign_key "trainings", "cities"
  add_foreign_key "trainings", "locations"
  add_foreign_key "trainings", "sessions"
end
