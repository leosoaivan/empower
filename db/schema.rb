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

ActiveRecord::Schema.define(version: 20180307030241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
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

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "contacts", "episodes"
  add_foreign_key "contacts", "users"
end
