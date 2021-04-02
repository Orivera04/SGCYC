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

ActiveRecord::Schema.define(version: 2021_04_02_034349) do

  create_table "accions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bancos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "siglas"
  end

  create_table "cargos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comprobantes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conyuges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "socios_id"
    t.string "nombre"
    t.string "apellido"
    t.string "numero_cedula"
    t.date "fecha_nacimiento"
    t.bigint "sexos_id"
    t.string "ocupacion"
    t.string "telefono"
    t.string "lugar_trabajo"
    t.integer "tiempo_laborar"
    t.string "direccion_domicilio"
    t.index ["sexos_id"], name: "index_conyuges_on_sexos_id"
    t.index ["socios_id"], name: "index_conyuges_on_socios_id"
  end

  create_table "empresas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre_comercial"
    t.integer "numero_telefono"
    t.string "correo"
    t.string "direccion"
    t.string "actividad_comercial"
    t.string "numero_ruc"
    t.text "logo_imagen", size: :long
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "escolaridads", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "estado_civils", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "fiadors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "socios_id"
    t.string "nombre"
    t.string "apellido"
    t.string "numero_cedula"
    t.string "domicilio"
    t.string "municipio"
    t.bigint "estado_civils_id"
    t.string "nombre_conyuge"
    t.string "profesion"
    t.string "lugar_trabajo"
    t.string "direccion_domicilio"
    t.string "telefono"
    t.integer "tiempo_laborar"
    t.integer "salario_mensual"
    t.integer "egreso_mensual"
    t.string "disponibilidad_al_mes"
    t.string "tiempo_conocer_solicitante"
    t.string "anio_parentesco"
    t.index ["estado_civils_id"], name: "index_fiadors_on_estado_civils_id"
    t.index ["socios_id"], name: "index_fiadors_on_socios_id"
  end

  create_table "forma_pagos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.bigint "tipo_moneda_id"
    t.bigint "bancos_id"
    t.index ["bancos_id"], name: "index_forma_pagos_on_bancos_id"
    t.index ["tipo_moneda_id"], name: "index_forma_pagos_on_tipo_moneda_id"
  end

  create_table "recursos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.bigint "tipo_recurso_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tipo_recurso_id"], name: "index_recursos_on_tipo_recurso_id"
  end

  create_table "rol_accions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "rol_id"
    t.bigint "recurso_id"
    t.bigint "accion_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accion_id"], name: "index_rol_accions_on_accion_id"
    t.index ["recurso_id"], name: "index_rol_accions_on_recurso_id"
    t.index ["rol_id"], name: "index_rol_accions_on_rol_id"
  end

  create_table "rols", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sexos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "socios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "codigo_socio"
    t.string "nombre"
    t.string "apellido"
    t.string "numero_cedula"
    t.date "fecha_nacimiento"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sexos_id"
    t.bigint "escolaridads_id"
    t.string "profesion"
    t.bigint "estado_civils_id"
    t.integer "anios_relacion"
    t.integer "numero_dependiente"
    t.bigint "tipo_domicilios_id"
    t.string "numero_telefono"
    t.string "direccion_domiciliar"
    t.string "municipio"
    t.string "departamento"
    t.string "empresa"
    t.string "numero_inss"
    t.string "direccion_empresa"
    t.string "departamento_empresa"
    t.string "municipio_empresa"
    t.string "numero_telefono_empresa"
    t.integer "tiempo_laborar"
    t.string "cargo"
    t.integer "salario_mensual"
    t.string "forma_pago"
    t.index ["escolaridads_id"], name: "index_socios_on_escolaridads_id"
    t.index ["estado_civils_id"], name: "index_socios_on_estado_civils_id"
    t.index ["sexos_id"], name: "index_socios_on_sexos_id"
    t.index ["tipo_domicilios_id"], name: "index_socios_on_tipo_domicilios_id"
  end

  create_table "tasa_cambios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "tasa_cambio", precision: 10, scale: 2
    t.date "fecha"
  end

  create_table "tipo_domicilios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "tipo_monedas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "simbolo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tipo_recursos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usuarios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nombre"
    t.boolean "activo"
    t.bigint "rols_id"
    t.bigint "cargos_id"
    t.index ["cargos_id"], name: "index_usuarios_on_cargos_id"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["rols_id"], name: "index_usuarios_on_rols_id"
  end

  create_table "valor_leches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "tasa_cambio", precision: 10, scale: 2
    t.date "fecha"
  end

  add_foreign_key "conyuges", "sexos", column: "sexos_id"
  add_foreign_key "conyuges", "socios", column: "socios_id"
  add_foreign_key "fiadors", "estado_civils", column: "estado_civils_id"
  add_foreign_key "fiadors", "socios", column: "socios_id"
  add_foreign_key "forma_pagos", "bancos", column: "bancos_id"
  add_foreign_key "forma_pagos", "tipo_monedas"
  add_foreign_key "recursos", "tipo_recursos"
  add_foreign_key "rol_accions", "accions"
  add_foreign_key "rol_accions", "recursos"
  add_foreign_key "rol_accions", "rols"
  add_foreign_key "socios", "escolaridads", column: "escolaridads_id"
  add_foreign_key "socios", "estado_civils", column: "estado_civils_id"
  add_foreign_key "socios", "sexos", column: "sexos_id"
  add_foreign_key "socios", "tipo_domicilios", column: "tipo_domicilios_id"
  add_foreign_key "usuarios", "cargos", column: "cargos_id"
  add_foreign_key "usuarios", "rols", column: "rols_id"
end
