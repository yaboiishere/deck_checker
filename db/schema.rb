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

ActiveRecord::Schema[8.0].define(version: 2025_06_21_130714) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "card_condition", ["mint", "near_mint", "excellent", "good", "played", "poor"]

  create_table "cards", force: :cascade do |t|
    t.string "name", null: false
    t.string "collector_number", null: false
    t.boolean "foil", null: false
    t.string "rarity", null: false
    t.integer "quantity", null: false
    t.string "scryfall_id"
    t.boolean "misprint", default: false, null: false
    t.boolean "altered", default: false, null: false
    t.float "price", default: 0.0, null: false
    t.enum "condition", null: false, enum_type: "card_condition"
    t.bigint "mtg_set_id", null: false
    t.bigint "language_id", null: false
    t.bigint "currency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_cards_on_currency_id"
    t.index ["language_id"], name: "index_cards_on_language_id"
    t.index ["mtg_set_id"], name: "index_cards_on_mtg_set_id"
    t.index ["name", "mtg_set_id", "collector_number", "language_id"], name: "idx_on_name_mtg_set_id_collector_number_language_id_8d469a23a6", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "symbol", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
    t.index ["name"], name: "index_currencies_on_name", unique: true
    t.index ["symbol"], name: "index_currencies_on_symbol", unique: true
  end

  create_table "languages", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.index ["code"], name: "index_languages_on_code", unique: true
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "mtg_sets", force: :cascade do |t|
    t.string "code"
    t.string "name", null: false
    t.index ["name"], name: "index_mtg_sets_on_name", unique: true
  end
end
