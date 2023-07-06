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

ActiveRecord::Schema[7.0].define(version: 2023_07_06_221755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hops", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "aroma_profile"
    t.string "flavor_profile"
    t.decimal "alpha_acids", precision: 4, scale: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "malts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "extract", precision: 3, scale: 1
    t.decimal "color", precision: 4, scale: 1
    t.decimal "ph", precision: 2, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yeasts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "dosage", precision: 4, scale: 1
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_yeasts_on_type"
  end

end
