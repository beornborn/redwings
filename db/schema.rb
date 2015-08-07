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

ActiveRecord::Schema.define(version: 20150807161806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.jsonb    "data",       default: {}
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "projects_users", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.jsonb    "data",       default: {}
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "projects_users", ["data"], name: "index_projects_users_on_data", using: :gin

  create_table "trello_backups", force: :cascade do |t|
    t.string   "board"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "admin",                           default: false
    t.datetime "created_at",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean  "deleted"
    t.string   "image_48"
    t.string   "first_name"
    t.string   "goodbye_reason"
    t.datetime "started_at"
    t.string   "goodbye_letter"
    t.string   "github"
    t.string   "mobile"
    t.string   "skype"
    t.text     "about",                           default: "Lorem ipsum dolor sit amet, consectetuer\n      adipiscing elit, sed diem nonummy nibh euismod tincidunt ut lacreet dolore magna\n      aliguam erat volutpat. Ut wisis enim ad minim veniam, quis nostrud exerci tution\n      ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis te feugifacilisi.\n      Duis autem dolor in hendrerit in vulputate velit esse molestie consequat, vel illum\n      dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui\n      blandit praesent luptatum zzril delenit au gue duis dolore te feugat nulla facilisi.\n      Ut wisi enim ad minim veniam, quis nostrud exerci taion ullamcorper suscipit lobortis\n      nisl ut aliquip ex en commodo consequat. Duis te feugifacilisi per suscipit lobortis\n      nisl ut aliquip ex en commodo consequat.Lorem ipsum dolor sit amet, consectetuer adipiscing\n      elit, sed diem nonummy nibh euismod tincidunt ut lacreet dolore magna aliguam erat volutpat.\n      Ut wisis enim ad minim veniam, quis nostrud exerci tution ullamcorper suscipit lobortis nisl"
    t.string   "image_192"
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
