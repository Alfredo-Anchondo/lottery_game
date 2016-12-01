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

ActiveRecord::Schema.define(version: 20161130210984) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",                    null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
  end

  create_table "enrachate_users", force: true do |t|
    t.integer  "question_enrachate_id"
    t.integer  "tira_enrachate_id"
    t.text     "answer"
    t.integer  "user_id"
    t.text     "status"
    t.datetime "purchase_date"
    t.integer  "enrachate_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "enrachates_id"
  end

  add_index "enrachate_users", ["enrachates_id"], name: "index_enrachate_users_on_enrachates_id", using: :btree
  add_index "enrachate_users", ["question_enrachate_id"], name: "index_enrachate_users_on_question_enrachate_id", using: :btree
  add_index "enrachate_users", ["tira_enrachate_id"], name: "index_enrachate_users_on_tira_enrachate_id", using: :btree
  add_index "enrachate_users", ["user_id"], name: "index_enrachate_users_on_user_id", using: :btree

  create_table "enrachates", force: true do |t|
    t.float    "price"
    t.float    "initial_balance"
    t.float    "percentage"
    t.integer  "type_enrachate"
    t.text     "description"
    t.integer  "winner"
    t.datetime "initial_date"
    t.datetime "end_date"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "access_key"
  end

  add_index "enrachates", ["user_id"], name: "index_enrachates_on_user_id", using: :btree

  create_table "error_reports", force: true do |t|
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "line_number"
    t.string   "referrer_url"
    t.string   "original_path"
    t.string   "enviroment"
    t.text     "description"
    t.text     "backtrace"
    t.datetime "error_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "error_reports", ["user_id"], name: "index_error_reports_on_user_id", using: :btree

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
    t.boolean  "to_mainpage"
  end

  add_index "lotteries", ["game_id"], name: "index_lotteries_on_game_id", using: :btree

  create_table "pick_survivor_weeks", force: true do |t|
    t.integer  "pick_id",               null: false
    t.integer  "survivor_week_game_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pick_survivor_weeks", ["pick_id"], name: "index_pick_survivor_weeks_on_pick_id", using: :btree
  add_index "pick_survivor_weeks", ["survivor_week_game_id"], name: "index_pick_survivor_weeks_on_survivor_week_game_id", using: :btree

  create_table "pick_user_games", force: true do |t|
    t.integer  "pick_user_id",     null: false
    t.integer  "team_id",          null: false
    t.integer  "survivor_game_id", null: false
    t.integer  "points",           null: false
    t.text     "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pick_user_games", ["pick_user_id"], name: "index_pick_user_games_on_pick_user_id", using: :btree
  add_index "pick_user_games", ["survivor_game_id"], name: "index_pick_user_games_on_survivor_game_id", using: :btree
  add_index "pick_user_games", ["team_id"], name: "index_pick_user_games_on_team_id", using: :btree

  create_table "pick_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "pick_survivor_week_id"
    t.float    "points"
    t.text     "status"
    t.integer  "local_score"
    t.integer  "visit_score"
    t.integer  "pick_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pick_users", ["pick_survivor_week_id"], name: "index_pick_users_on_pick_survivor_week_id", using: :btree
  add_index "pick_users", ["pick_user_id"], name: "index_pick_users_on_pick_user_id", using: :btree
  add_index "pick_users", ["user_id"], name: "index_pick_users_on_user_id", using: :btree

  create_table "picks", force: true do |t|
    t.string   "name",                                  null: false
    t.text     "description"
    t.integer  "user_id",                               null: false
    t.integer  "sport_category_id",                     null: false
    t.float    "price",                   default: 1.0, null: false
    t.float    "initial_balance",         default: 1.0, null: false
    t.string   "access_key"
    t.integer  "users_quantity"
    t.float    "percentage",              default: 0.0
    t.integer  "pick_type"
    t.integer  "winner_type"
    t.float    "percentage_per_week",     default: 0.0
    t.float    "first_percentage"
    t.float    "second_percentage"
    t.float    "third_percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.boolean  "to_mainpage"
  end

  add_index "picks", ["sport_category_id"], name: "index_picks_on_sport_category_id", using: :btree
  add_index "picks", ["user_id"], name: "index_picks_on_user_id", using: :btree

  create_table "question_enrachates", force: true do |t|
    t.text     "title"
    t.text     "answer1"
    t.text     "answer2"
    t.datetime "program_date"
    t.string   "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "title",       null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiniela_questions", force: true do |t|
    t.integer  "question_id", null: false
    t.integer  "quiniela_id", null: false
    t.text     "value"
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
    t.text     "initial_balance",                       null: false
    t.text     "price"
    t.text     "description"
    t.text     "winner_number"
    t.integer  "game_id",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "purchase_gift_tickets",   default: "0"
    t.string   "last_questions"
    t.string   "last_questions_text"
    t.string   "cap_result_file_name"
    t.string   "cap_result_content_type"
    t.integer  "cap_result_file_size"
    t.datetime "cap_result_updated_at"
    t.boolean  "to_mainpage"
  end

  add_index "quinielas", ["game_id"], name: "index_quinielas_on_game_id", using: :btree

  create_table "relation_enrachate_tiras", force: true do |t|
    t.integer  "enrachate_id"
    t.integer  "tira_enrachate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relation_enrachate_tiras", ["enrachate_id"], name: "index_relation_enrachate_tiras_on_enrachate_id", using: :btree
  add_index "relation_enrachate_tiras", ["tira_enrachate_id"], name: "index_relation_enrachate_tiras_on_tira_enrachate_id", using: :btree

  create_table "relation_tira_questions", force: true do |t|
    t.integer  "tira_enrachate_id"
    t.integer  "question_enrachate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relation_tira_questions", ["question_enrachate_id"], name: "index_relation_tira_questions_on_question_enrachate_id", using: :btree
  add_index "relation_tira_questions", ["tira_enrachate_id"], name: "index_relation_tira_questions_on_tira_enrachate_id", using: :btree

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

  create_table "survivor_games", force: true do |t|
    t.integer  "team_id",                          null: false
    t.integer  "team2_id",                         null: false
    t.float    "handicap"
    t.integer  "plus_handicap"
    t.text     "description"
    t.datetime "game_date",                        null: false
    t.integer  "winner_team"
    t.integer  "survivor_week_game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "local_score"
    t.integer  "visit_score"
    t.string   "type_update",           limit: 30
  end

  add_index "survivor_games", ["survivor_week_game_id"], name: "index_survivor_games_on_survivor_week_game_id", using: :btree
  add_index "survivor_games", ["team2_id"], name: "index_survivor_games_on_team2_id", using: :btree
  add_index "survivor_games", ["team_id"], name: "index_survivor_games_on_team_id", using: :btree

  create_table "survivor_users", force: true do |t|
    t.integer  "team_id"
    t.datetime "purchase_date",                                null: false
    t.integer  "user_id",                                      null: false
    t.string   "status",                    default: "bought", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survivor_week_survivor_id",                    null: false
    t.integer  "survivor_user_id"
  end

  add_index "survivor_users", ["team_id"], name: "index_survivor_users_on_team_id", using: :btree
  add_index "survivor_users", ["user_id"], name: "index_survivor_users_on_user_id", using: :btree

  create_table "survivor_week_games", force: true do |t|
    t.date     "initial_date",                   null: false
    t.date     "final_date",                     null: false
    t.integer  "week",           default: 1,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",         default: false, null: false
    t.integer  "sport_category"
  end

  create_table "survivor_week_survivors", force: true do |t|
    t.integer  "survivor_id",           null: false
    t.integer  "survivor_week_game_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survivor_week_survivors", ["survivor_id"], name: "index_survivor_week_survivors_on_survivor_id", using: :btree
  add_index "survivor_week_survivors", ["survivor_week_game_id"], name: "index_survivor_week_survivors_on_survivor_week_game_id", using: :btree

  create_table "survivors", force: true do |t|
    t.string   "name",                                               null: false
    t.text     "description"
    t.float    "price",                              default: 0.0,   null: false
    t.float    "initial_balance",                    default: 0.0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_key"
    t.float    "percentage"
    t.integer  "user_id"
    t.boolean  "closed",                             default: false, null: false
    t.integer  "rebuy_quantity",                     default: 1,     null: false
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.integer  "user_quantity"
    t.string   "status",                  limit: 30
    t.boolean  "to_mainpage"
  end

  create_table "teams", force: true do |t|
    t.string   "name",                         null: false
    t.string   "description"
    t.integer  "sport_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "team_abbr",         limit: 30
  end

  add_index "teams", ["sport_category_id"], name: "index_teams_on_sport_category_id", using: :btree

  create_table "tira_enrachates", force: true do |t|
    t.datetime "program_date"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_lotteries", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "lottery_id",    null: false
    t.string   "status",        null: false
    t.string   "ticket_number", null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "openpay_id"
    t.string   "favorite_team"
    t.date     "birthday"
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

  add_foreign_key "pick_survivor_weeks", "picks", name: "pick_survivor_weeks_pick_id_fk"
  add_foreign_key "pick_survivor_weeks", "survivor_week_games", name: "pick_survivor_weeks_survivor_week_game_id_fk"

  add_foreign_key "pick_user_games", "pick_users", name: "pick_user_games_pick_user_id_fk"
  add_foreign_key "pick_user_games", "survivor_games", name: "pick_user_games_survivor_game_id_fk"
  add_foreign_key "pick_user_games", "teams", name: "pick_user_games_team_id_fk"

  add_foreign_key "pick_users", "pick_survivor_weeks", name: "pick_users_pick_survivor_week_id_fk"
  add_foreign_key "pick_users", "pick_users", name: "pick_users_pick_user_id_fk"
  add_foreign_key "pick_users", "users", name: "pick_users_user_id_fk"

  add_foreign_key "picks", "sport_categories", name: "picks_sport_category_id_fk"
  add_foreign_key "picks", "users", name: "picks_user_id_fk"

  add_foreign_key "quiniela_questions", "questions", name: "quiniela_questions_question_id_fk"
  add_foreign_key "quiniela_questions", "quinielas", name: "quiniela_questions_quiniela_id_fk"

  add_foreign_key "quiniela_users", "quinielas", name: "quiniela_users_quiniela_id_fk"
  add_foreign_key "quiniela_users", "users", name: "quiniela_users_user_id_fk"

  add_foreign_key "quinielas", "games", name: "quinielas_game_id_fk"

  add_foreign_key "sport_categories", "categories", name: "sport_categories_category_id_fk"
  add_foreign_key "sport_categories", "sports", name: "sport_categories_sport_id_fk"

  add_foreign_key "survivor_games", "survivor_week_games", name: "survivor_games_survivor_week_game_id_fk"
  add_foreign_key "survivor_games", "teams", name: "survivor_games_team2_id_fk", column: "team2_id"
  add_foreign_key "survivor_games", "teams", name: "survivor_games_team_id_fk"

  add_foreign_key "survivor_users", "survivor_week_survivors", name: "survivor_users_survivor_week_survivor_id_fkey"
  add_foreign_key "survivor_users", "teams", name: "survivor_users_team_id_fk"
  add_foreign_key "survivor_users", "users", name: "survivor_users_user_id_fk"

  add_foreign_key "survivor_week_survivors", "survivor_week_games", name: "survivor_week_survivors_survivor_week_game_id_fk"
  add_foreign_key "survivor_week_survivors", "survivors", name: "survivor_week_survivors_survivor_id_fk"

  add_foreign_key "survivors", "users", name: "usersfk"

  add_foreign_key "teams", "sport_categories", name: "teams_sport_category_id_fk"

  add_foreign_key "user_lotteries", "lotteries", name: "user_lotteries_lottery_id_fk"
  add_foreign_key "user_lotteries", "users", name: "user_lotteries_user_id_fk"

  add_foreign_key "users", "roles", name: "users_role_id_fk"

end
