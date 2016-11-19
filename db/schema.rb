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

ActiveRecord::Schema.define(version: 20161117075800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address1"
    t.string   "post_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.integer  "contact_id"
    t.integer  "address_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "telephone_number"
    t.string   "mobile_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "damages", force: :cascade do |t|
    t.date     "damage_entry_date"
    t.integer  "week_no"
    t.integer  "bags_count"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "inward_manufacture_details", force: :cascade do |t|
    t.datetime "manufacture_week"
    t.integer  "week_number"
    t.integer  "quantity"
    t.string   "grading"
    t.string   "packing"
    t.integer  "inward_id"
    t.boolean  "isactive"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "inwards", force: :cascade do |t|
    t.integer  "truck_number"
    t.integer  "inward_number"
    t.datetime "inward_date"
    t.integer  "damage_bags_count"
    t.boolean  "return"
    t.integer  "total_quantity"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "location_name"
    t.integer  "status"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "outward_approvals", force: :cascade do |t|
    t.datetime "dispatch_date"
    t.string   "party_name"
    t.datetime "billing_date"
    t.integer  "status"
    t.integer  "outward_id"
    t.boolean  "isactive"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "outward_manufacture_details", force: :cascade do |t|
    t.datetime "manufacture_week"
    t.integer  "week_number"
    t.integer  "quantity"
    t.string   "grading"
    t.string   "packing"
    t.integer  "outward_id"
    t.boolean  "isactive"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "outwards", force: :cascade do |t|
    t.string   "truck_number"
    t.string   "outward_number"
    t.datetime "outward_date"
    t.integer  "location_id"
    t.integer  "dispatch_type"
    t.integer  "total_quantity"
    t.integer  "payment_type"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "status"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_type"
    t.boolean  "isactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.string   "password"
    t.integer  "role_id"
    t.integer  "contact_id"
    t.integer  "address_id"
    t.integer  "warehouse_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "warehouses", force: :cascade do |t|
    t.string   "warehouse_name"
    t.integer  "contact_id"
    t.integer  "address_id"
    t.integer  "company_id"
    t.boolean  "isactive"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end