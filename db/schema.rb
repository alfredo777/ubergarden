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

ActiveRecord::Schema.define(version: 20170511054303) do

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "token"
    t.string   "password"
    t.string   "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_products", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "categorico_id"
    t.string   "categorico_type"
    t.boolean  "sub_categoria"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name_downcase_no_characters"
  end

  create_table "category_products_and_products", force: :cascade do |t|
    t.integer  "category_product_id"
    t.integer  "product_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "image_products", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.string   "codigo"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "session_token"
  end

  create_table "productos_a_pedidos", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "pedido_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "session_token"
  end

  create_table "products", force: :cascade do |t|
    t.string   "nombre"
    t.float    "precio"
    t.string   "nombre_cientifico"
    t.string   "luz"
    t.string   "riego"
    t.text     "necesidades"
    t.text     "descripccion"
    t.string   "tamano"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "name_downcase_no_characters"
    t.string   "pais_de_procedencia"
    t.string   "region_climatica"
    t.string   "familia"
    t.string   "orden"
    t.string   "categoria_principal_interna"
    t.boolean  "publicado",                   default: false
    t.string   "color1"
    t.string   "color2"
    t.string   "color3"
    t.string   "color4"
    t.string   "color5"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.string   "state"
    t.string   "postal_code"
    t.integer  "uid"
    t.string   "avatar"
    t.text     "address"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
