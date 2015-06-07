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

ActiveRecord::Schema.define(version: 20150607134037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "resource_stories", force: :cascade do |t|
    t.integer  "stories_id"
    t.integer  "resource_id"
    t.integer  "story_id"
    t.integer  "place_num"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resource_stories", ["stories_id"], name: "index_resource_stories_on_stories_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.integer  "resource_stories_id"
    t.string   "url"
    t.text     "description"
    t.string   "type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "resources", ["resource_stories_id"], name: "index_resources_on_resource_stories_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.boolean  "ready"
    t.string   "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
