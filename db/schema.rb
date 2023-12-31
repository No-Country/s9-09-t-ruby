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

ActiveRecord::Schema[7.0].define(version: 2023_07_25_201710) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "general_configurations", force: :cascade do |t|
    t.decimal "efficiency_extract", precision: 4, scale: 1, default: "70.0"
    t.decimal "evaporation_percentage", precision: 4, scale: 1, default: "20.0"
    t.integer "bioling_time", default: 60
    t.decimal "loss_temp", precision: 4, scale: 1, default: "0.0"
    t.decimal "grain_temp", precision: 4, scale: 1, default: "20.0"
    t.decimal "water_grain_ratio", precision: 3, scale: 1, default: "3.0"
    t.decimal "mashing_temp", precision: 4, scale: 1, default: "68.0"
    t.decimal "sparging_temp", precision: 4, scale: 1, default: "70.0"
    t.integer "sparging_time", default: 20
    t.integer "chilling_time", default: 30
    t.integer "turbiduty_loss", default: 3
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mashing_time", default: 60
    t.index ["user_id"], name: "index_general_configurations_on_user_id"
  end

  create_table "hops", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "aroma_profile"
    t.string "flavor_profile"
    t.decimal "alpha_acids", precision: 4, scale: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_hops_on_user_id"
  end

  create_table "ingredient_items", force: :cascade do |t|
    t.decimal "quantity", precision: 5, scale: 1
    t.string "addable_type"
    t.bigint "addable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recipe_id", null: false
    t.string "boil_time"
    t.index ["addable_type", "addable_id"], name: "index_ingredient_items_on_addable"
    t.index ["recipe_id"], name: "index_ingredient_items_on_recipe_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.integer "available"
    t.string "inventoriable_type"
    t.bigint "inventoriable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventoriable_type", "inventoriable_id"], name: "index_inventory_items_on_inventoriable"
  end

  create_table "inventory_movements", force: :cascade do |t|
    t.integer "quantity", null: false
    t.integer "movement_type", null: false
    t.bigint "inventory_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_item_id"], name: "index_inventory_movements_on_inventory_item_id"
  end

  create_table "lots", force: :cascade do |t|
    t.string "code", null: false
    t.integer "batch", null: false
    t.string "status"
    t.bigint "recipe_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_lots_on_recipe_id"
    t.index ["user_id"], name: "index_lots_on_user_id"
  end

  create_table "malts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "extract", precision: 3, scale: 1
    t.decimal "color", precision: 4, scale: 1
    t.decimal "ph", precision: 2, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_malts_on_user_id"
  end

  create_table "mash_steps", force: :cascade do |t|
    t.decimal "start_temp", precision: 4, scale: 1, null: false
    t.decimal "final_temp", precision: 4, scale: 1, null: false
    t.integer "length_time", null: false
    t.bigint "mash_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mash_id"], name: "index_mash_steps_on_mash_id"
  end

  create_table "mashes", force: :cascade do |t|
    t.decimal "water_grain_ratio", precision: 3, scale: 1, null: false
    t.decimal "temp", precision: 4, scale: 1, null: false
    t.integer "time", null: false
    t.integer "recirculation_time", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_mashes_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "style", null: false
    t.decimal "batch", precision: 6, scale: 1, null: false
    t.decimal "og", precision: 5, scale: 1
    t.decimal "fg", precision: 5, scale: 1
    t.decimal "abv", precision: 3, scale: 1
    t.decimal "color", precision: 4, scale: 1
    t.decimal "ibus", precision: 4, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "status"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.integer "todo_type", null: false
    t.string "status"
    t.hstore "transitions", default: [], array: true
    t.bigint "lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
    t.index ["lot_id"], name: "index_todos_on_lot_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "yeasts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "dosage", precision: 4, scale: 1
    t.integer "yeast_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "attenuation", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_yeasts_on_user_id"
    t.index ["yeast_type"], name: "index_yeasts_on_yeast_type"
  end

  add_foreign_key "general_configurations", "users"
  add_foreign_key "hops", "users"
  add_foreign_key "ingredient_items", "recipes"
  add_foreign_key "inventory_movements", "inventory_items"
  add_foreign_key "lots", "recipes"
  add_foreign_key "lots", "users"
  add_foreign_key "malts", "users"
  add_foreign_key "mash_steps", "mashes"
  add_foreign_key "mashes", "recipes"
  add_foreign_key "recipes", "users"
  add_foreign_key "todos", "lots"
  add_foreign_key "yeasts", "users"
end
