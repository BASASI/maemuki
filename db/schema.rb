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

ActiveRecord::Schema.define(version: 20141106194145) do

  create_table "identities", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.datetime "expires_at"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "latest_id"
    t.integer  "oldest_id"
  end

  add_index "identities", ["uid", "provider"], name: "index_identities_on_uid_and_provider"
  add_index "identities", ["uid"], name: "index_identities_on_uid"
  add_index "identities", ["user_id", "provider"], name: "index_identities_on_user_id_and_provider"

  create_table "statistics", force: true do |t|
    t.date     "date"
    t.integer  "positive_count", default: 0
    t.integer  "negative_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.integer  "count",          default: 0
  end

  create_table "users", force: true do |t|
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screen_name"
    t.string   "image"
    t.datetime "last_analyzed_at"
    t.string   "description"
  end

  add_index "users", ["name"], name: "index_users_on_name"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
