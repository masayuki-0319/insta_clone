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

ActiveRecord::Schema.define(version: 2019_04_30_043113) do

  create_table "photo_likes", force: :cascade do |t|
    t.integer "liker_id"
    t.integer "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liker_id", "photo_id"], name: "index_photo_likes_on_liker_id_and_photo_id", unique: true
    t.index ["photo_id"], name: "index_photo_likes_on_photo_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "picture"
    t.string "title"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_photos_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "user_relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_user_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_user_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_user_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.string "pen_name"
    t.string "provider"
    t.string "uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
