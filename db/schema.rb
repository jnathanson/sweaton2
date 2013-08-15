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

ActiveRecord::Schema.define(version: 20130814172917) do

  create_table "attendings", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "repeated",   default: false
  end

  add_index "attendings", ["event_id"], name: "index_attendings_on_event_id"
  add_index "attendings", ["user_id", "event_id"], name: "index_attendings_on_user_id_and_event_id", unique: true
  add_index "attendings", ["user_id"], name: "index_attendings_on_user_id"

  create_table "diary_entries", force: true do |t|
    t.integer  "user_id"
    t.datetime "start_time"
    t.boolean  "repeating"
    t.integer  "event_id",   default: 0
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps",       default: true
    t.integer  "day"
    t.string   "cost"
    t.string   "contact"
    t.string   "website"
    t.string   "gender"
  end

  add_index "events", ["start_time"], name: "index_events_on_start_time"
  add_index "events", ["venue_id"], name: "index_events_on_venue_id"

  create_table "favourites", force: true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favourites", ["user_id", "venue_id"], name: "index_favourites_on_user_id_and_venue_id", unique: true
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id"
  add_index "favourites", ["venue_id"], name: "index_favourites_on_venue_id"

  create_table "relationships", force: true do |t|
    t.integer  "tag_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["event_id"], name: "index_relationships_on_event_id"
  add_index "relationships", ["tag_id", "event_id"], name: "index_relationships_on_tag_id_and_event_id", unique: true
  add_index "relationships", ["tag_id"], name: "index_relationships_on_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.boolean  "mentor",          default: false
    t.boolean  "organiser",       default: false
    t.string   "home_address"
    t.string   "home_postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps",           default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "street_address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps",          default: true
  end

  add_index "venues", ["name"], name: "index_venues_on_name"

end
