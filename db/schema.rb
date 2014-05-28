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

ActiveRecord::Schema.define(version: 20140528140019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: true do |t|
    t.string   "name"
    t.string   "body"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "certifications", force: true do |t|
    t.integer "company_id"
    t.integer "certificate_id"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "industry_id"
    t.text     "result_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name"], name: "index_companies_on_name", using: :btree

  create_table "industries", force: true do |t|
    t.string "name"
  end

end
