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

ActiveRecord::Schema.define(version: 20171229014409) do

  create_table "bands", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.integer "genre_id"
    t.index ["genre_id"], name: "index_bands_on_genre_id"
    t.index ["manager_id"], name: "index_bands_on_manager_id"
  end

  create_table "genre_skills", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_skills_on_genre_id"
    t.index ["skill_id"], name: "index_genre_skills_on_skill_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.string "style"
    t.integer "min_members"
    t.integer "max_members"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "member_bands", force: :cascade do |t|
    t.integer "member_id"
    t.integer "band_id"
    t.integer "skill_id"
    t.datetime "joined_band_at"
    t.datetime "left_band_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_member_bands_on_band_id"
    t.index ["member_id"], name: "index_member_bands_on_member_id"
    t.index ["skill_id"], name: "index_member_bands_on_skill_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", default: ""
    t.string "gender", default: ""
    t.date "birthdate"
    t.integer "cost", default: 0, null: false
    t.integer "trait_stamina", default: 0, null: false
    t.integer "trait_ego", default: 0, null: false
    t.integer "trait_looks", default: 0, null: false
    t.integer "trait_drive", default: 0, null: false
    t.integer "trait_productivity", default: 0, null: false
    t.integer "trait_aptitude", default: 0, null: false
    t.integer "trait_creativity", default: 0, null: false
    t.integer "trait_network", default: 0, null: false
    t.integer "trait_fatigue", default: 0, null: false
    t.integer "skill_primary"
    t.integer "skill_primary_level", default: 0
    t.integer "skill_secondary"
    t.integer "skill_secondary_level", default: 0
    t.integer "skill_tertiary"
    t.integer "skill_tertiary_level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
