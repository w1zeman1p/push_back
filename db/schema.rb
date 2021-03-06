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

ActiveRecord::Schema.define(version: 20140314000224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friend_requests", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_requests", ["recipient_id"], name: "index_friend_requests_on_recipient_id", using: :btree
  add_index "friend_requests", ["sender_id", "recipient_id"], name: "index_friend_requests_on_sender_id_and_recipient_id", unique: true, using: :btree
  add_index "friend_requests", ["sender_id"], name: "index_friend_requests_on_sender_id", using: :btree

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "body"
    t.integer  "author_id"
    t.integer  "recipient_id"
    t.string   "message_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["author_id"], name: "index_messages_on_author_id", using: :btree
  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "f_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "daily_goal"
    t.string   "session_token"
    t.string   "l_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

  create_table "workout_sets", force: true do |t|
    t.integer  "reps"
    t.integer  "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_sets", ["workout_id"], name: "index_workout_sets_on_workout_id", using: :btree

  create_table "workouts", force: true do |t|
    t.date     "completed_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id", using: :btree

end
