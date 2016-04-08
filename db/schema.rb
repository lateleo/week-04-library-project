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

ActiveRecord::Schema.define(version: 16) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
  end

  create_table "copies", force: :cascade do |t|
    t.integer "work_id"
    t.integer "branch_id"
    t.integer "patron_id"
  end

  create_table "patrons", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "staff_members", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.integer "branch_id"
  end

  create_table "works", force: :cascade do |t|
    t.string  "title"
    t.string  "author"
    t.string  "isbn"
    t.integer "year"
  end

end
