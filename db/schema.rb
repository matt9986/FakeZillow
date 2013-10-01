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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131001184136) do

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "listings", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "price"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "listings", ["city", "state"], :name => "index_listings_on_city_and_state"
  add_index "listings", ["price"], :name => "index_listings_on_price"
  add_index "listings", ["slug"], :name => "index_listings_on_slug", :unique => true
  add_index "listings", ["user_id"], :name => "index_listings_on_user_id"
  add_index "listings", ["zip"], :name => "index_listings_on_zip"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "pass_hash"
    t.boolean  "agent",         :default => false
    t.string   "session_token"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true

end
