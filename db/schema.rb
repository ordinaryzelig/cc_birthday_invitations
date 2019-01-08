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

ActiveRecord::Schema.define(version: 2019_01_08_035254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "invitations", force: :cascade do |t|
    t.citext "first_name"
    t.citext "last_name"
    t.citext "email"
    t.integer "status", default: 0, null: false
    t.citext "code", null: false
    t.string "dj_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_invitations_on_code", unique: true
  end

  create_table "song_requests", force: :cascade do |t|
    t.bigint "invitation_id"
    t.string "title", null: false
    t.string "artist", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitation_id"], name: "index_song_requests_on_invitation_id"
  end

  add_foreign_key "song_requests", "invitations"
end
