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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160901131251) do

  create_table "chickout_coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chickout_items", force: :cascade do |t|
    t.decimal  "price"
    t.integer  "quantity"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
  end

  add_index "chickout_items", ["order_id"], name: "index_chickout_items_on_order_id"
  add_index "chickout_items", ["product_id"], name: "index_chickout_items_on_product_id"

  create_table "chickout_orders", force: :cascade do |t|
    t.decimal  "total_price"
    t.date     "completed_date"
    t.string   "state"
    t.string   "next_step"
    t.string   "shipping_method"
    t.decimal  "shipping_price"
    t.decimal  "subtotal"
    t.integer  "customer_id"
    t.integer  "credit_card_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "coupon_id"
  end

  add_index "chickout_orders", ["billing_address_id"], name: "index_chickout_orders_on_billing_address_id"
  add_index "chickout_orders", ["coupon_id"], name: "index_chickout_orders_on_coupon_id"
  add_index "chickout_orders", ["credit_card_id"], name: "index_chickout_orders_on_credit_card_id"
  add_index "chickout_orders", ["customer_id"], name: "index_chickout_orders_on_customer_id"
  add_index "chickout_orders", ["shipping_address_id"], name: "index_chickout_orders_on_shipping_address_id"

  create_table "produkts", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
