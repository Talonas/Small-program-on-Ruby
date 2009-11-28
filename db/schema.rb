# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091128114317) do

  create_table "albums", :force => true do |t|
    t.integer "artist_id"
    t.string  "name"
    t.integer "year"
    t.string  "genre"
  end

  create_table "artists", :force => true do |t|
    t.string "name"
  end

  create_table "stores", :force => true do |t|
    t.integer "album_id"
    t.integer "amount"
    t.integer "price"
    t.integer "self_price"
  end

  create_table "user_history", :force => true do |t|
    t.integer "user_id"
    t.integer "album_id"
    t.integer "price"
  end

  create_table "users", :force => true do |t|
    t.string  "name"
    t.string  "surname"
    t.integer "age"
    t.string  "gender"
    t.string  "adress"
    t.string  "email"
  end

end
