# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120717233433) do

  create_table "airports", :force => true do |t|
    t.string   "airport_code"
    t.string   "city"
    t.string   "country_code"
    t.string   "iata_code"
    t.string   "icao_code"
    t.string   "name"
    t.string   "state_code"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "type"
    t.string   "faa_code"
  end

  create_table "carriers", :force => true do |t|
    t.string   "airline_code"
    t.string   "iata_code"
    t.string   "icao_code"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "type"
  end

  create_table "coverages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "equipment", :force => true do |t|
    t.string   "aircraft_type_code"
    t.string   "aircraft_type_name"
    t.boolean  "jet"
    t.boolean  "regional"
    t.boolean  "turboprop"
    t.boolean  "wide_body"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "flight_coverages", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "premium"
    t.float    "c60_120"
    t.float    "c120_180"
    t.float    "c180_240"
    t.float    "c240_or_more"
    t.float    "cc"
    t.integer  "coverage_id"
    t.integer  "checked"
  end

  create_table "flight_legs", :force => true do |t|
    t.boolean  "codeshare"
    t.integer  "arrival_date_adjustment"
    t.string   "arrival_terminal"
    t.datetime "arrival_time"
    t.integer  "departure_date_adjustment"
    t.string   "departure_terminal"
    t.datetime "departure_time"
    t.integer  "distance_miles"
    t.integer  "flight_duration_minutes"
    t.integer  "layover_duration_minutes"
    t.string   "wetlease_info"
    t.integer  "flightid_flight_number"
    t.integer  "operator_flight_number"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "equipment_id"
    t.integer  "flightid_carrier_id"
    t.integer  "operator_carrier_id"
    t.integer  "departure_airport_id"
    t.integer  "arrival_airport_id"
    t.integer  "flight_coverage_id"
  end

  create_table "flight_searches", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "flight_number"
    t.integer  "main_search_id"
    t.string   "departure_date"
    t.string   "origin"
    t.string   "destination"
  end

  create_table "main_searches", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
