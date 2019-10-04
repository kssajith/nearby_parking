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

ActiveRecord::Schema.define(version: 2019_10_04_192946) do

  create_table "carparks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "car_park_no"
    t.string "address"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.integer "car_park_type"
    t.integer "type_of_parking_system"
    t.string "short_term_parking"
    t.string "free_parking"
    t.integer "night_parking"
    t.integer "car_park_decks"
    t.float "gantry_height"
    t.integer "car_park_basement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_lots"
    t.integer "lots_available", default: 0
    t.datetime "availability_updated_at"
    t.index ["car_park_no"], name: "index_carparks_on_car_park_no"
  end

end
