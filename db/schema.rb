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

ActiveRecord::Schema.define(version: 2020_04_07_184402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "number"
    t.integer "digit"
    t.string "bank_branch"
    t.decimal "balance"
    t.bigint "bank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
  end

  create_table "bank_transactions", force: :cascade do |t|
    t.string "operation"
    t.string "summary"
    t.decimal "amount"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_bank_transactions_on_account_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "bank_name"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "beneficiaries", force: :cascade do |t|
    t.string "beneficiary_name"
    t.string "document"
    t.integer "account_number"
    t.integer "account_digit"
    t.string "bank_branch"
    t.bigint "bank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_beneficiaries_on_bank_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.bigint "bank_transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_transaction_id"], name: "index_deposits_on_bank_transaction_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "beneficiary_id"
    t.bigint "bank_transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_transaction_id"], name: "index_transfers_on_bank_transaction_id"
    t.index ["beneficiary_id"], name: "index_transfers_on_beneficiary_id"
  end

  add_foreign_key "accounts", "banks"
  add_foreign_key "bank_transactions", "accounts"
  add_foreign_key "beneficiaries", "banks"
  add_foreign_key "deposits", "bank_transactions"
  add_foreign_key "transfers", "bank_transactions"
  add_foreign_key "transfers", "beneficiaries"
end
