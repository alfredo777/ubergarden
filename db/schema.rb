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

ActiveRecord::Schema.define(version: 20170705175448) do

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

  create_table "customer_registers", force: :cascade do |t|
    t.string   "customer_token_conekta"
    t.string   "customer_email"
    t.string   "customer_phone"
    t.string   "customer_name"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "image_products", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.string   "session_token"
    t.text     "line_items",    limit: 4294967296
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.string   "codigo"
    t.integer  "user_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "session_token"
    t.string   "nombre_persona_que_ordena"
    t.string   "apellidos_persona_que_ordena"
    t.string   "persona_autorizada_a_recoger_1"
    t.string   "persona_autorizada_a_recoger_2"
    t.string   "persona_autorizada_a_recoger_3"
    t.string   "persona_autorizada_a_recoger_4"
    t.string   "telefono_fijo"
    t.string   "telefono_oficina"
    t.string   "telefono_celular"
    t.text     "direccion"
    t.string   "calle"
    t.string   "numero_interior"
    t.string   "numero_exterior"
    t.string   "colonia"
    t.string   "localidad"
    t.string   "estado"
    t.string   "pais"
    t.string   "metodo_de_pago"
    t.boolean  "anonimo",                        default: false
    t.string   "metodo_de_envio"
    t.float    "costo_de_envio"
    t.float    "monto_total_del_pedido"
    t.text     "cuantificador"
    t.string   "estatus_del_pedido"
    t.boolean  "activacion_de_pedido",           default: false
    t.boolean  "finalizacion_de_pedido",         default: false
    t.float    "total"
    t.boolean  "aceptacion_de_terminos",         default: false
    t.string   "conekta_customer"
    t.string   "conekta_order"
    t.integer  "cpostal"
    t.string   "email"
    t.string   "email2"
    t.integer  "customer_register_id"
  end

  create_table "productos_a_pedidos", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "pedido_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "session_token"
    t.string   "color"
    t.integer  "offer"
    t.float    "price"
    t.float    "total_price"
    t.integer  "quanty"
  end

  create_table "productos_in_lines", force: :cascade do |t|
    t.string   "session_token"
    t.text     "productos_in_line", limit: 4294967296
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
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

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "suscriptors", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tag_id_and_product_ids", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.string   "downcase_title"
    t.string   "code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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
