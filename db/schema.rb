# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150427001400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string   "name"
    t.string   "guid"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "channels", ["event_id", "name"], name: "index_channels_on_event_id_and_name", unique: true, using: :btree
  add_index "channels", ["event_id"], name: "index_channels_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "cover_photo_url"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "description"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "event_map_url"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "notification_guts"
    t.string   "type"
    t.integer  "channel_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "notifications", ["channel_id"], name: "index_notifications_on_channel_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.integer  "notification_id"
    t.string   "option_guts"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "options", ["notification_id"], name: "index_options_on_notification_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.integer  "option_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "responses", ["option_id"], name: "index_responses_on_option_id", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "subevents", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "event_id"
    t.string   "name"
    t.string   "location"
  end

  add_index "subevents", ["event_id"], name: "index_subevents_on_event_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "admin",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "subscriptions", ["event_id"], name: "index_subscriptions_on_event_id", using: :btree
  add_index "subscriptions", ["user_id", "event_id"], name: "index_subscriptions_on_user_id_and_event_id", unique: true, using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "locked",                 default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "authentication_token"
    t.string   "facebook_id"
    t.string   "facebook_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "channels", "events"
  add_foreign_key "notifications", "channels"
  add_foreign_key "options", "notifications"
  add_foreign_key "responses", "options"
  add_foreign_key "responses", "users"
  add_foreign_key "subevents", "events"
  add_foreign_key "subscriptions", "events"
  add_foreign_key "subscriptions", "users"
end
