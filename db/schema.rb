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

ActiveRecord::Schema.define(version: 20180205110236) do

  create_table "card_type_mcc_codes", force: :cascade do |t|
    t.integer "card_type_id", null: false
    t.integer "mcc_code_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type_id"], name: "index_card_type_mcc_codes_on_card_type_id"
    t.index ["mcc_code_id"], name: "index_card_type_mcc_codes_on_mcc_code_id"
  end

  create_table "card_types", force: :cascade do |t|
    t.integer "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string "card_number", null: false
    t.date "expire_date", null: false
    t.integer "ccv", null: false
    t.integer "card_type_id", null: false
    t.integer "employees_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type_id"], name: "index_cards_on_card_type_id"
    t.index ["employees_id"], name: "index_cards_on_employees_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "uniqe_id", null: false
    t.string "name", null: false
    t.string "mobile_no"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financial_years", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mcc_codes", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "months_limits", force: :cascade do |t|
    t.integer "month", null: false
    t.integer "limit", null: false
    t.integer "mcc_code_id", null: false
    t.integer "financial_year_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["financial_year_id"], name: "index_months_limits_on_financial_year_id"
    t.index ["mcc_code_id"], name: "index_months_limits_on_mcc_code_id"
  end

  create_table "spendings", force: :cascade do |t|
    t.integer "amount", null: false
    t.integer "transaction_id", null: false
    t.integer "months_limit_id", null: false
    t.integer "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_spendings_on_employee_id"
    t.index ["months_limit_id"], name: "index_spendings_on_months_limit_id"
    t.index ["transaction_id"], name: "index_spendings_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "mobile_no", null: false
    t.integer "employee_id", null: false
    t.integer "card_number", null: false
    t.string "merchant_name", null: false
    t.datetime "transaction_time", null: false
    t.integer "amount", null: false
    t.boolean "status", null: false
    t.string "mcc_code", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_transactions_on_card_id"
    t.index ["employee_id"], name: "index_transactions_on_employee_id"
  end

end
