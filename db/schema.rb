# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 18) do

  create_table "airplane", :force => true do |t|
    t.string   "plane_type"
    t.string   "code",       :limit => 6
    t.integer  "seats",      :limit => 4, :default => 120
    t.datetime "made_when"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airport", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "gps_position"
    t.float    "inbound_fee"
    t.float    "outbound_fee"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airticket", :force => true do |t|
    t.string   "reservation_code"
    t.float    "price"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cc_nr"
  end

  create_table "airticket_item", :force => true do |t|
    t.integer  "flight_id"
    t.integer  "airticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked",      :default => false
  end

  create_table "boarding_pass", :force => true do |t|
    t.integer  "airticket_item_id"
    t.integer  "luggage_pcs"
    t.float    "luggage_weight"
    t.string   "seat_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crew", :force => true do |t|
    t.string   "first_name"
    t.string   "surname"
    t.string   "empno"
    t.float    "salary"
    t.date     "birthday"
    t.integer  "airport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer", :force => true do |t|
    t.string   "first_name"
    t.string   "surname"
    t.string   "birth_number", :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "address"
  end

  create_table "flight", :force => true do |t|
    t.string   "code"
    t.integer  "airport_to_id"
    t.integer  "airport_from_id"
    t.datetime "leaves_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "free_seats"
    t.integer  "price"
    t.integer  "airplane_id"
    t.boolean  "boarded",         :default => false
  end

  create_table "flight_crew", :force => true do |t|
    t.integer  "flight_id"
    t.integer  "crew_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
