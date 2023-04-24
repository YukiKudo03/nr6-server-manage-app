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

ActiveRecord::Schema[7.0].define(version: 2023_03_26_110240) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_reserve_events", force: :cascade do |t|
    t.datetime "reserved_at", null: false
    t.bigint "instrument_id", null: false
    t.integer "execution_type", default: 0, null: false
    t.integer "execution_status", default: 0, null: false
    t.bigint "reserve_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_current_reserve_events_on_instrument_id"
    t.index ["reserve_event_id"], name: "index_current_reserve_events_on_reserve_event_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "serial", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_instruments_on_email", unique: true
    t.index ["reset_password_token"], name: "index_instruments_on_reset_password_token", unique: true
  end

  create_table "reserve_events", force: :cascade do |t|
    t.bigint "instrument_id", null: false
    t.datetime "set_time", null: false
    t.datetime "completed_at"
    t.datetime "declined_at"
    t.text "input_text", null: false
    t.text "output_text", null: false
    t.integer "execution_type", default: 0, null: false
    t.integer "reserve_events_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_reserve_events_on_instrument_id"
  end

  add_foreign_key "current_reserve_events", "instruments"
  add_foreign_key "current_reserve_events", "reserve_events"
  add_foreign_key "reserve_events", "instruments"
end
