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

ActiveRecord::Schema.define(version: 20140501121916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_holders", force: true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "privilege"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.decimal  "starting_balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_transfers", force: true do |t|
    t.integer  "src_account_id"
    t.integer  "target_account_id"
    t.date     "tran_date"
    t.decimal  "amount"
    t.string   "description"
    t.integer  "src_user_id"
    t.integer  "target_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group",      default: "user"
  end

  create_table "recurring_transactions", force: true do |t|
    t.integer  "account_id"
    t.string   "interval"
    t.string   "description"
    t.decimal  "amount"
    t.string   "sign"
    t.boolean  "active"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "last_updated"
    t.integer  "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "reports", force: true do |t|
    t.integer  "user_id"
    t.date     "sdate",       default: '2014-03-01'
    t.date     "edate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "range",       default: false
    t.string   "sign"
    t.integer  "category_id", default: [],           array: true
    t.integer  "account_id",  default: [],           array: true
    t.string   "description"
    t.string   "supplier"
    t.decimal  "amount"
  end

  create_table "statements", force: true do |t|
    t.integer  "acc_id"
    t.date     "edate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.date     "tran_date"
    t.integer  "account_id"
    t.integer  "category_id"
    t.string   "description"
    t.string   "supplier"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sign"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
