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

ActiveRecord::Schema[7.0].define(version: 2022_06_01_142730) do
  create_table "account_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "account_id"
    t.integer "user_id"
    t.boolean "approve_orders", default: false
    t.boolean "make_payments", default: false
    t.boolean "receive_shipments", default: false
    t.boolean "removed", default: false
    t.boolean "administrator", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "company_name", limit: 100
    t.string "first_name", limit: 100
    t.string "last_name", limit: 100
    t.string "match_key", limit: 100
    t.string "address"
    t.string "address2"
    t.string "city", limit: 50
    t.string "state", limit: 5
    t.string "country", limit: 2
    t.string "zip", limit: 10
    t.string "phone", limit: 14
    t.string "toll_free_number", limit: 14
    t.string "fax", limit: 14
    t.datetime "created"
    t.integer "rep_id"
    t.integer "primary_users"
  end

  create_table "count_status_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "count_id"
    t.integer "user_id"
    t.integer "status"
    t.integer "results"
    t.string "ref_no", limit: 50
    t.datetime "created"
    t.text "notes"
    t.text "selects"
    t.text "attachments"
  end

  create_table "counts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "client"
    t.integer "user_id", null: false
    t.integer "processor_id"
    t.integer "status", null: false
    t.integer "results"
    t.string "name", limit: 100
    t.string "email"
    t.string "ref_no", limit: 100
    t.datetime "created", null: false
    t.datetime "updated", null: false
    t.datetime "submitted"
    t.datetime "completed"
    t.text "selects"
    t.text "notes"
    t.text "attachments"
    t.integer "is_flagged", limit: 1, default: 0
  end

  create_table "invoice", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "status", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.decimal "amount_due", precision: 10, scale: 2, null: false
    t.string "payment_terms", limit: 50, null: false
    t.datetime "due"
    t.datetime "date_shipped"
    t.datetime "created", null: false
    t.datetime "updated", null: false
    t.text "billing_address"
    t.text "notes"
    t.text "legalese"
    t.text "products"
  end

  create_table "invoice_status_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_confirmations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id", null: false
    t.string "name", limit: 100, null: false
    t.datetime "created", precision: nil
    t.string "ip", limit: 25
    t.string "useragent"
    t.datetime "timestamp", precision: nil
    t.string "file", limit: 100
    t.string "job_title", limit: 100
  end

  create_table "order_status_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.datetime "date"
    t.integer "status"
    t.text "notes"
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "client"
    t.integer "partner_id"
    t.decimal "amount", precision: 10, scale: 2
    t.string "payoptions"
    t.string "payment_terms", limit: 50
    t.datetime "created"
    t.datetime "updated"
    t.integer "status"
    t.boolean "emails"
    t.integer "count"
    t.string "classification", limit: 5
    t.string "shipping_method", limit: 100
    t.text "shipping_address"
    t.text "billing_address"
    t.text "discount"
    t.text "notes"
    t.text "products"
    t.string "fulfillment_type", limit: 30
  end

  create_table "pay_periods", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "start_date", precision: nil, null: false
    t.datetime "end_date", precision: nil, null: false
    t.datetime "run_date", precision: nil, null: false
    t.datetime "last_processed", precision: nil
    t.datetime "payment_date", precision: nil
    t.string "file_name", limit: 100
    t.string "description", limit: 100
    t.text "notes"
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.integer "subscription_id"
    t.integer "submitted_by", null: false
    t.integer "trans_check_id"
    t.integer "trans_credit_id"
    t.string "method_of_payment", limit: 20, null: false
    t.string "reference_no", limit: 50, null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "notes", null: false
    t.datetime "created", null: false
    t.datetime "export_date"
  end

  create_table "payroll_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "order_id"
    t.integer "po_id"
    t.integer "partner_id"
    t.integer "pay_period_id"
    t.integer "rep"
    t.string "rep_name", limit: 100, null: false
    t.string "client", limit: 100, null: false
    t.datetime "date", precision: nil
    t.string "payment_method", limit: 20, null: false
    t.string "ref", limit: 50, null: false
    t.string "classification", limit: 4
    t.decimal "amount_paid", precision: 10, scale: 2, null: false
    t.decimal "commissionable_amount", precision: 10, scale: 2, null: false
    t.decimal "commission_percentage", precision: 10, scale: 3, null: false
    t.decimal "commission", precision: 10, scale: 2, null: false
    t.decimal "po_amount", precision: 10, scale: 2
    t.decimal "previously_paid", precision: 10, scale: 2, null: false
    t.boolean "is_adjustment", null: false
    t.datetime "updated", precision: nil, null: false
    t.string "notes"
  end

  create_table "payroll_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "order_id"
    t.integer "po_id"
    t.integer "payment_id"
    t.integer "payroll_item_id"
    t.integer "rep"
    t.datetime "date", precision: nil
    t.decimal "amount_paid", precision: 10, scale: 2, null: false
    t.decimal "po_amount", precision: 10, scale: 2
    t.decimal "vendor_cost", precision: 10, scale: 2, null: false
    t.string "notes"
  end

  create_table "purchase_order_status_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "po_id"
    t.integer "user_id"
    t.datetime "date"
    t.string "status", limit: 20
    t.text "notes", size: :long
    t.text "attachments"
  end

  create_table "purchase_orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "order_id"
    t.integer "vendor_id"
    t.integer "processor"
    t.integer "partner_id"
    t.integer "sequence_id"
    t.decimal "amount", precision: 10, scale: 2
    t.integer "status"
    t.datetime "neededby"
    t.string "po"
    t.string "currentpo"
    t.datetime "created"
    t.datetime "updated"
    t.datetime "completed"
    t.datetime "export_date"
    t.text "shipping_address"
    t.text "products"
    t.text "notes"
    t.text "shipping_method"
    t.boolean "is_flagged"
  end

  create_table "shipments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "order_id"
    t.integer "purchase_order_id"
    t.integer "user_id"
    t.integer "processor_id"
    t.integer "quantity"
    t.text "file_location"
    t.text "description"
    t.text "notes"
    t.datetime "shipment_date"
    t.datetime "created"
  end

  create_table "terms_and_conditions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "active_date", precision: nil, null: false
    t.datetime "inactive_date", precision: nil
    t.string "url", null: false
    t.string "description", limit: 100, null: false
    t.string "classification", limit: 4, null: false
    t.string "display", limit: 100, null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "role_id"
    t.string "email"
    t.string "password", limit: 32
    t.string "first_name", limit: 100
    t.string "last_name", limit: 100
    t.string "phone", limit: 14
    t.string "phone_extension", limit: 10
    t.string "cell_phone", limit: 14
    t.string "recover", limit: 12
    t.datetime "created", null: false
    t.datetime "last_login"
  end

  create_table "vendors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "contact_name", limit: 100, null: false
    t.string "contact_email", limit: 100, null: false
    t.datetime "created", precision: nil, null: false
    t.string "name", limit: 100
    t.string "match_key", limit: 100
    t.string "address"
    t.string "address2"
    t.string "city", limit: 50
    t.string "state", limit: 2
    t.string "country", limit: 2, default: "US", null: false
    t.string "zip", limit: 10
    t.string "phone", limit: 14
    t.string "toll_free_number", limit: 14
    t.string "cust_service_number", limit: 14
    t.string "fax", limit: 14
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
