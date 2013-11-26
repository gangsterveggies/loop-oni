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

ActiveRecord::Schema.define(version: 20131126000234) do

  create_table "articles", force: true do |t|
    t.text     "content"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["title"], name: "index_articles_on_title"

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
    t.boolean  "admin",           default: false
    t.string   "profile_image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
