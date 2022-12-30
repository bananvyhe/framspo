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

ActiveRecord::Schema.define(version: 2022_12_29_135636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dropitems", force: :cascade do |t|
    t.bigint "mob_id"
    t.bigint "listitem_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["listitem_id"], name: "index_dropitems_on_listitem_id"
    t.index ["mob_id"], name: "index_dropitems_on_mob_id"
  end

  create_table "listitems", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "desc"
    t.string "item"
    t.float "rate"
    t.index ["item"], name: "index_listitems_on_item", unique: true
    t.index ["title"], name: "index_listitems_on_title", unique: true
  end

  create_table "mobs", force: :cascade do |t|
    t.string "name"
    t.string "hp"
    t.string "loa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "my_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "listitem_id"
    t.bigint "qty", default: 0
    t.integer "position"
    t.index ["listitem_id"], name: "index_my_items_on_listitem_id"
    t.index ["user_id"], name: "index_my_items_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "pic"
    t.string "head"
    t.string "date"
    t.string "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "biglink"
    t.string "fullarticle"
    t.string "link"
    t.index ["link"], name: "index_news_on_link", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.integer "upvotes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0, null: false
    t.integer "loa", default: 0
  end

  add_foreign_key "my_items", "listitems"
  add_foreign_key "my_items", "users"
  add_foreign_key "todos", "users"
end
