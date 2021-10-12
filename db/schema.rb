# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_12_201608) do

  create_table "developer_profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "social_name"
    t.date "date_birth"
    t.string "academic_formation"
    t.string "performance_zone"
    t.string "professional_experiences"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "developer_id", null: false
    t.index ["developer_id"], name: "index_developer_profiles_on_developer_id"
  end

  create_table "developers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_developers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_developers_on_reset_password_token", unique: true
  end

  create_table "project_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_project_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_project_owners_on_reset_password_token", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "requirements"
    t.decimal "maximum_value_per_hour"
    t.date "end_date"
    t.integer "working_model"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_owner_id", null: false
    t.index ["project_owner_id"], name: "index_projects_on_project_owner_id"
  end

  add_foreign_key "developer_profiles", "developers"
  add_foreign_key "projects", "project_owners"
end
