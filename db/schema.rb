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

ActiveRecord::Schema.define(version: 20140330102508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "trantype_id"
    t.date     "sdate"
    t.date     "edate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "range",       default: false
    t.string   "sign",        default: "DEBIT"
  end

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.date     "tran_date"
    t.integer  "trantype_id"
    t.integer  "category_id"
    t.string   "description"
    t.string   "supplier"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sign",        default: "DEBIT"
  end

  create_table "trantypes", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
