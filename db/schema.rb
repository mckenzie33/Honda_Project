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

ActiveRecord::Schema.define(version: 20150209172423) do

  create_table "groups", force: true do |t|
    t.string   "groupname"
    t.string   "description"
    t.string   "owner_email"
    t.integer  "owner_id"
    t.boolean  "is_public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_name"
  end

  create_table "mat_memberships", force: true do |t|
    t.boolean  "is_confirmed"
    t.string   "requested_by"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mat_name"
    t.string   "group_name"
  end

  create_table "materials", force: true do |t|
    t.float    "density"
    t.float    "elastic_modulus"
    t.float    "shear_modulus"
    t.float    "poissons_ratio"
    t.float    "yield_strength"
    t.float    "ultimate_tensile_strength"
    t.float    "ultimate_total_elongation"
    t.float    "hardness_value"
    t.float    "melting_point"
    t.float    "thermal_expansion"
    t.float    "thermal_conductivity"
    t.float    "specific_heat"
    t.float    "electrical_resistivity"
    t.float    "chemical_composition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mat_name"
    t.string   "mat_type"
    t.string   "confidence_level"
  end

  add_index "materials", ["mat_name", "mat_type"], name: "index_materials_on_mat_name_and_mat_type", unique: true

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_confirmed"
    t.string   "comments"
  end

  create_table "testfiles", force: true do |t|
    t.string   "filename"
    t.string   "uploaded_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mat_name"
    t.string   "groupname"
    t.string   "comments"
    t.string   "person_in_charge"
    t.string   "test_location"
    t.date     "test_date"
    t.string   "confidence_level"
    t.string   "file_type"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "avatar"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
