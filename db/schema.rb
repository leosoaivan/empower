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

ActiveRecord::Schema.define(version: 2018_08_27_210933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "telephone"
    t.hstore "address"
    t.integer "children"
    t.string "gender"
    t.string "email"
    t.string "special_population"
    t.string "ethnicity"
    t.string "language"
  end

  create_table "contacts", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "episode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_contacts_on_episode_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "contacts_services", id: false, force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "service_id", null: false
    t.index ["contact_id"], name: "index_contacts_services_on_contact_id"
    t.index ["service_id"], name: "index_contacts_services_on_service_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "petitioner_id"
    t.integer "respondent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "relationship", array: true
    t.string "victimization", array: true
    t.boolean "arrest"
    t.boolean "open", default: true
    t.index ["petitioner_id"], name: "index_episodes_on_petitioner_id"
    t.index ["respondent_id"], name: "index_episodes_on_respondent_id"
  end

  create_table "follow_ups", force: :cascade do |t|
    t.datetime "due_by_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "due_by_shift"
    t.bigint "episode_id"
    t.index ["episode_id"], name: "index_follow_ups_on_episode_id"
    t.index ["user_id"], name: "index_follow_ups_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_type_id"
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "contacts", "episodes"
  add_foreign_key "contacts", "users"
  add_foreign_key "follow_ups", "episodes"
  add_foreign_key "follow_ups", "users"
  add_foreign_key "services", "service_types"
end
