# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_06_001647) do

  create_table "boards", force: :cascade do |t|
    t.text "current_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "initial_state"
    t.integer "generation"
    t.integer "alive_count"
    t.integer "dead_count"
    t.text "current_stay_alive_count"
    t.text "current_revive_count"
    t.text "initial_revive_count"
    t.text "initial_stay_alive_count"
  end

end
