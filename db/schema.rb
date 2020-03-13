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

ActiveRecord::Schema.define(version: 2020_03_13_134139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allocated_leaves", force: :cascade do |t|
    t.integer "user_id"
    t.integer "total_leave"
    t.integer "used_leave", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "year"
    t.index ["user_id", "year"], name: "index_allocated_leaves_on_user_id_and_year"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: false
    t.date "date"
    t.index ["user_id", "date"], name: "index_attendances_on_user_id_and_date"
  end

  create_table "budgets", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "month"
    t.integer "year"
    t.decimal "expense", default: "0.0"
    t.integer "category_id"
    t.index ["month", "year", "category_id"], name: "index_budgets_on_month_and_year_and_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "product_name"
    t.decimal "cost"
    t.string "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "budget_id"
    t.date "expense_date"
    t.integer "status", default: 0
    t.integer "category_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "amount"
    t.date "income_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "source"
    t.integer "status", default: 0
  end

  create_table "leaves", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.text "reason"
    t.string "leave_type"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "phone"
    t.string "name"
    t.string "role"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.decimal "target_amount"
    t.decimal "bonus_percentage"
    t.string "designation"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
