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

ActiveRecord::Schema.define(version: 20161025091038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_rooms", force: :cascade do |t|
    t.string   "crmable_type"
    t.integer  "crmable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["crmable_type", "crmable_id"], name: "index_chat_rooms_on_crmable_type_and_crmable_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "chat_room_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["chat_room_id"], name: "index_comments_on_chat_room_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "folder_share_authorities", force: :cascade do |t|
    t.integer  "folder_id"
    t.integer  "user_id"
    t.boolean  "can_create",   default: true
    t.boolean  "can_view",     default: true
    t.boolean  "can_rename",   default: false
    t.boolean  "can_move",     default: false
    t.boolean  "can_destroy",  default: false
    t.boolean  "direct_share", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["folder_id", "user_id"], name: "index_folder_share_authorities_on_folder_id_and_user_id", unique: true, using: :btree
    t.index ["folder_id"], name: "index_folder_share_authorities_on_folder_id", using: :btree
    t.index ["user_id"], name: "index_folder_share_authorities_on_user_id", using: :btree
  end

  create_table "folder_shortcuts", force: :cascade do |t|
    t.integer  "shortcut_id"
    t.integer  "destination_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["destination_id"], name: "index_folder_shortcuts_on_destination_id", using: :btree
    t.index ["shortcut_id", "destination_id"], name: "index_folder_shortcuts_on_shortcut_id_and_destination_id", unique: true, using: :btree
    t.index ["shortcut_id"], name: "index_folder_shortcuts_on_shortcut_id", using: :btree
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
    t.text     "ancestry"
    t.index ["creator_id"], name: "index_folders_on_creator_id", using: :btree
  end

  create_table "up_file_share_authorities", force: :cascade do |t|
    t.integer  "up_file_id"
    t.integer  "user_id"
    t.boolean  "can_view",     default: true
    t.boolean  "can_rename",   default: false
    t.boolean  "can_move",     default: false
    t.boolean  "can_destroy",  default: false
    t.boolean  "direct_share", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["up_file_id", "user_id"], name: "index_up_file_share_authorities_on_up_file_id_and_user_id", unique: true, using: :btree
    t.index ["up_file_id"], name: "index_up_file_share_authorities_on_up_file_id", using: :btree
    t.index ["user_id"], name: "index_up_file_share_authorities_on_user_id", using: :btree
  end

  create_table "up_file_shortcuts", force: :cascade do |t|
    t.integer  "up_file_id"
    t.integer  "folder_id"
    t.boolean  "shortcut",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["folder_id"], name: "index_up_file_shortcuts_on_folder_id", using: :btree
    t.index ["up_file_id", "folder_id"], name: "index_up_file_shortcuts_on_up_file_id_and_folder_id", unique: true, using: :btree
    t.index ["up_file_id"], name: "index_up_file_shortcuts_on_up_file_id", using: :btree
  end

  create_table "up_files", force: :cascade do |t|
    t.string   "link"
    t.string   "file_name"
    t.string   "file_type"
    t.integer  "file_size"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "uploader_id", null: false
    t.string   "temp_up_id"
    t.string   "status"
    t.index ["uploader_id"], name: "index_up_files_on_uploader_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "username"
    t.string   "authentication_token",   limit: 30
    t.boolean  "admin",                             default: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "comments", "chat_rooms"
  add_foreign_key "comments", "users"
  add_foreign_key "folder_share_authorities", "folders"
  add_foreign_key "folder_share_authorities", "users"
  add_foreign_key "folders", "users", column: "creator_id"
  add_foreign_key "up_file_share_authorities", "up_files"
  add_foreign_key "up_file_share_authorities", "users"
  add_foreign_key "up_file_shortcuts", "folders"
  add_foreign_key "up_file_shortcuts", "up_files"
  add_foreign_key "up_files", "users", column: "uploader_id"
end
