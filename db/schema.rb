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

ActiveRecord::Schema.define(version: 20150131193240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_items", force: :cascade do |t|
    t.integer  "word_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_items", ["course_id"], name: "index_course_items_on_course_id", using: :btree
  add_index "course_items", ["word_id"], name: "index_course_items_on_word_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "learned_words", force: :cascade do |t|
    t.integer  "times_repeated", default: 0
    t.boolean  "completed",      default: false
    t.datetime "last_learned"
    t.integer  "word_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "learned_words", ["user_id"], name: "index_learned_words_on_user_id", using: :btree
  add_index "learned_words", ["word_id"], name: "index_learned_words_on_word_id", using: :btree

  create_table "learnings", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "learnings", ["course_id"], name: "index_learnings_on_course_id", using: :btree
  add_index "learnings", ["user_id"], name: "index_learnings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "words", force: :cascade do |t|
    t.string   "translation"
    t.string   "kana"
    t.string   "romaji"
    t.string   "kanji"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
