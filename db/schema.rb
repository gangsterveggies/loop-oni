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

ActiveRecord::Schema.define(version: 20131224043240) do

  create_table "add_announcements", force: true do |t|
    t.text     "message"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", force: true do |t|
    t.text     "message"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "announcements", ["begin_date"], name: "index_announcements_on_begin_date"

  create_table "articles", force: true do |t|
    t.text     "content"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["title"], name: "index_articles_on_title"

  create_table "contests", force: true do |t|
    t.string   "title"
    t.string   "topic"
    t.string   "link"
    t.integer  "duration"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "contests", ["begin_date"], name: "index_contests_on_begin_date"
  add_index "contests", ["title"], name: "index_contests_on_title"
  add_index "contests", ["topic"], name: "index_contests_on_topic"

  create_table "participate_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participate_relationships", ["user_id", "contest_id"], name: "index_participate_relationships_on_user_id_and_contest_id", unique: true
  add_index "participate_relationships", ["user_id"], name: "index_participate_relationships_on_user_id"

  create_table "read_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "read_relationships", ["user_id", "article_id"], name: "index_read_relationships_on_user_id_and_article_id", unique: true
  add_index "read_relationships", ["user_id"], name: "index_read_relationships_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "graduation_year"
    t.string   "school"
    t.string   "city"
    t.integer  "qualifications"
    t.integer  "finals"
    t.integer  "iois"
    t.integer  "wins"
    t.integer  "bronze"
    t.integer  "silver"
    t.integer  "gold"
    t.integer  "contestant_type"
    t.boolean  "admin",                  default: false
    t.string   "profile_image"
    t.datetime "announcement_hide_time"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
