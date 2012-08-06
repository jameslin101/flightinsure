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

ActiveRecord::Schema.define(:version => 20120806171801) do

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

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "coverage_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "paid_time"
    t.integer  "paypal_ipn_id"
  end

  create_table "paypal_ipns", :force => true do |t|
    t.string   "payment_request_date"
    t.string   "return_url"
    t.string   "fees_payer"
    t.string   "ipn_notification_url"
    t.string   "sender_email"
    t.string   "verify_sign"
    t.string   "test_ipn"
    t.string   "cancel_url"
    t.string   "pay_key"
    t.string   "action_type"
    t.string   "transaction_type"
    t.string   "status"
    t.string   "log_default_shipping_address_in_transaction"
    t.string   "charset"
    t.string   "notify_version"
    t.string   "reverse_all_parallel_payments_on_error"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "paypal_transactions", :force => true do |t|
    t.string   "id_for_sender_txn"
    t.string   "receiver"
    t.string   "is_primary_receiver"
    t.string   "status"
    t.string   "paymentType"
    t.string   "status_for_sender_txn"
    t.string   "pending_reason"
    t.string   "amount"
    t.integer  "paypal_ipn_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "id_for_paypal_transaction"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "credit_card_number"
    t.string   "expiration_month"
    t.string   "expiration_year"
    t.string   "card_security_code"
    t.string   "stripe_customer_token"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
