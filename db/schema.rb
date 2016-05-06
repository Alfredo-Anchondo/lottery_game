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

ActiveRecord::Schema.define(version: 20160503184726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",              null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "games", force: true do |t|
    t.integer  "team_id"
    t.datetime "game_date",   null: false
    t.text     "description"
    t.integer  "local_score"
    t.integer  "visit_score"
    t.integer  "team2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["team_id"], name: "index_games_on_team_id", using: :btree

  create_table "lotteries", force: true do |t|
    t.float    "initial_balance",                     null: false
    t.text     "rules",                               null: false
    t.text     "description"
    t.integer  "game_id",                             null: false
    t.integer  "winner_number"
    t.integer  "initial_number",                      null: false
    t.integer  "final_number",                        null: false
    t.float    "price",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "purchase_gift_tickets", default: "0"
  end

  add_index "lotteries", ["game_id"], name: "index_lotteries_on_game_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiniela_questions", force: true do |t|
    t.integer  "question_id", null: false
    t.integer  "quiniela_id", null: false
    t.text     "value",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quiniela_questions", ["question_id"], name: "index_quiniela_questions_on_question_id", using: :btree
  add_index "quiniela_questions", ["quiniela_id"], name: "index_quiniela_questions_on_quiniela_id", using: :btree

  create_table "quiniela_users", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "quiniela_id",   null: false
    t.text     "ticket_number", null: false
    t.text     "status"
    t.datetime "purchase_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quiniela_users", ["quiniela_id"], name: "index_quiniela_users_on_quiniela_id", using: :btree
  add_index "quiniela_users", ["user_id"], name: "index_quiniela_users_on_user_id", using: :btree

  create_table "quinielas", force: true do |t|
    t.text     "initial_balance", null: false
    t.text     "price"
    t.text     "description"
    t.integer  "game_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quinielas", ["game_id"], name: "index_quinielas_on_game_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.boolean  "is_admin"
    t.boolean  "is_client"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sport_categories", force: true do |t|
    t.integer  "sport_id",    null: false
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sport_categories", ["category_id"], name: "index_sport_categories_on_category_id", using: :btree
  add_index "sport_categories", ["sport_id"], name: "index_sport_categories_on_sport_id", using: :btree

  create_table "sports", force: true do |t|
    t.string   "name",              null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name",              null: false
    t.string   "description"
    t.integer  "sport_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "teams", ["sport_category_id"], name: "index_teams_on_sport_category_id", using: :btree

  create_table "user_lotteries", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "lottery_id",    null: false
    t.string   "status",        null: false
    t.integer  "ticket_number", null: false
    t.datetime "purchase_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_lotteries", ["lottery_id"], name: "index_user_lotteries_on_lottery_id", using: :btree
  add_index "user_lotteries", ["user_id"], name: "index_user_lotteries_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                                            null: false
    t.string   "last_name",                                       null: false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "zip_code"
    t.integer  "age"
    t.string   "email",                                           null: false
    t.string   "phone"
    t.string   "cellphone"
    t.float    "balance",                           default: 0.0
    t.integer  "role_id",                                         null: false
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.integer  "int_number"
    t.integer  "ext_number"
    t.string   "username",                                        null: false
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",                default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "favorite_team",          limit: 30
    t.date     "birthday"
    t.string   "openpay_id"
    t.string   "gender"
    t.string   "language",               limit: 30
    t.string   "friend_reference"
    t.string   "gift_credit",                       default: "0"
    t.string   "reference_by_friend"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "games", "teams", name: "games_team_id_fk"

  add_foreign_key "lotteries", "games", name: "lotteries_game_id_fk"

  add_foreign_key "quiniela_questions", "questions", name: "quiniela_questions_question_id_fk"
  add_foreign_key "quiniela_questions", "quinielas", name: "quiniela_questions_quiniela_id_fk"

  add_foreign_key "quiniela_users", "quinielas", name: "quiniela_users_quiniela_id_fk"
  add_foreign_key "quiniela_users", "users", name: "quiniela_users_user_id_fk"

  add_foreign_key "quinielas", "games", name: "quinielas_game_id_fk"

  add_foreign_key "sport_categories", "categories", name: "sport_categories_category_id_fk"
  add_foreign_key "sport_categories", "sports", name: "sport_categories_sport_id_fk"

  add_foreign_key "teams", "sport_categories", name: "teams_sport_category_id_fk"

  add_foreign_key "user_lotteries", "lotteries", name: "user_lotteries_lottery_id_fk"
  add_foreign_key "user_lotteries", "users", name: "user_lotteries_user_id_fk"

  add_foreign_key "users", "roles", name: "users_role_id_fk"

end
