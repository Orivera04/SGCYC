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

ActiveRecord::Schema[7.0].define(version: 2021_04_27_014504) do
  create_table "accions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "antecedente_crediticios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pagare_id"
    t.string "institucion"
    t.date "fecha"
    t.decimal "monto", precision: 10, scale: 2
    t.decimal "saldo", precision: 10, scale: 2
    t.index ["pagare_id"], name: "index_antecedente_crediticios_on_pagare_id"
  end

  create_table "bancos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "siglas"
  end

  create_table "cargos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comprobante_detalles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "comprobante_id"
    t.bigint "forma_pago_id"
    t.decimal "monto_pagado", precision: 10, scale: 2
    t.string "referencia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comprobante_id"], name: "index_comprobante_detalles_on_comprobante_id"
    t.index ["forma_pago_id"], name: "index_comprobante_detalles_on_forma_pago_id"
  end

  create_table "comprobantes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "numero_comprobante"
    t.bigint "pagare_id"
    t.bigint "usuario_id"
    t.bigint "socio_id"
    t.bigint "tipo_moneda_id"
    t.decimal "monto_pagado", precision: 10, scale: 2
    t.string "observacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pagare_id"], name: "index_comprobantes_on_pagare_id"
    t.index ["socio_id"], name: "index_comprobantes_on_socio_id"
    t.index ["tipo_moneda_id"], name: "index_comprobantes_on_tipo_moneda_id"
    t.index ["usuario_id"], name: "index_comprobantes_on_usuario_id"
  end

  create_table "cuotas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pagare_id"
    t.date "fecha_pago"
    t.integer "numero_cuota"
    t.decimal "cuota", precision: 10, scale: 2
    t.decimal "mora", precision: 10, scale: 2
    t.decimal "monto_abonado", precision: 10, scale: 2
    t.boolean "cancelado"
    t.index ["pagare_id"], name: "index_cuotas_on_pagare_id"
  end

  create_table "empresas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre_comercial"
    t.integer "numero_telefono"
    t.string "correo"
    t.string "direccion"
    t.string "actividad_comercial"
    t.string "numero_ruc"
    t.text "logo_imagen", size: :long
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "escolaridads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "estado_civils", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "fiadors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "socio_id"
    t.string "nombre"
    t.string "apellido"
    t.string "numero_cedula"
    t.string "domicilio"
    t.string "municipio"
    t.bigint "estado_civil_id"
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
    t.index ["estado_civil_id"], name: "index_fiadors_on_estado_civil_id"
    t.index ["socio_id"], name: "index_fiadors_on_socio_id"
  end

  create_table "forma_pagos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.bigint "tipo_moneda_id"
    t.bigint "bancos_id"
    t.bigint "tipo_pago_id"
    t.decimal "equivalencia", precision: 10
    t.index ["bancos_id"], name: "index_forma_pagos_on_bancos_id"
    t.index ["tipo_moneda_id"], name: "index_forma_pagos_on_tipo_moneda_id"
    t.index ["tipo_pago_id"], name: "index_forma_pagos_on_tipo_pago_id"
  end

  create_table "interes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cantidad"
  end

  create_table "pagares", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "usuario_id"
    t.bigint "socio_id"
    t.bigint "tipo_moneda_id"
    t.integer "numero_pagare"
    t.decimal "cantidad_solicitada", precision: 10, scale: 2
    t.bigint "plazo_id"
    t.bigint "interes_id"
    t.string "forma_pago"
    t.decimal "cuota_pagar", precision: 10, scale: 2
    t.string "destino_credito"
    t.string "ubicacion_inversion"
    t.string "garantias_ofrecidas"
    t.boolean "aceptar_condiciones_diferentes"
    t.boolean "tuvo_credito"
    t.boolean "tiene_credito_actualmente"
    t.string "garantia_hipotecaria"
    t.integer "cantidad_leche_entregada"
    t.string "observaciones"
    t.boolean "cancelado", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interes_id"], name: "index_pagares_on_interes_id"
    t.index ["plazo_id"], name: "index_pagares_on_plazo_id"
    t.index ["socio_id"], name: "index_pagares_on_socio_id"
    t.index ["tipo_moneda_id"], name: "index_pagares_on_tipo_moneda_id"
    t.index ["usuario_id"], name: "index_pagares_on_usuario_id"
  end

  create_table "plazos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.integer "plazo"
  end

  create_table "recursos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.bigint "tipo_recurso_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tipo_recurso_id"], name: "index_recursos_on_tipo_recurso_id"
  end

  create_table "referencia_personal_pagares", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pagare_id"
    t.string "nombre"
    t.string "domicilio"
    t.string "telefono"
    t.index ["pagare_id"], name: "index_referencia_personal_pagares_on_pagare_id"
  end

  create_table "rol_accions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "rol_id"
    t.bigint "recurso_id"
    t.bigint "accion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accion_id"], name: "index_rol_accions_on_accion_id"
    t.index ["recurso_id"], name: "index_rol_accions_on_recurso_id"
    t.index ["rol_id"], name: "index_rol_accions_on_rol_id"
  end

  create_table "rols", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sexos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "socios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "codigo_socio"
    t.string "nombre"
    t.string "apellido"
    t.string "numero_cedula"
    t.date "fecha_nacimiento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sexo_id"
    t.bigint "escolaridad_id"
    t.string "profesion"
    t.bigint "estado_civil_id"
    t.integer "anios_relacion"
    t.integer "numero_dependiente"
    t.bigint "tipo_domicilio_id"
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
    t.string "nombre_conyuge"
    t.string "apellido_conyuge"
    t.string "numero_cedula_conyuge"
    t.date "fecha_nacimiento_conyuge"
    t.string "ocupacion_conyuge"
    t.string "telefono_conyuge"
    t.string "lugar_trabajo_conyuge"
    t.integer "tiempo_laborar_conyuge"
    t.string "direccion_domicilio_conyuge"
    t.integer "sexo_id_conyuge"
    t.index ["escolaridad_id"], name: "index_socios_on_escolaridad_id"
    t.index ["estado_civil_id"], name: "index_socios_on_estado_civil_id"
    t.index ["sexo_id"], name: "index_socios_on_sexo_id"
    t.index ["tipo_domicilio_id"], name: "index_socios_on_tipo_domicilio_id"
  end

  create_table "tasa_cambios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "tasa_cambio", precision: 10, scale: 2
    t.date "fecha"
  end

  create_table "tipo_domicilios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "tipo_monedas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "simbolo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_pagos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "tipo_recursos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.boolean "activo"
    t.bigint "rols_id"
    t.bigint "cargos_id"
    t.index ["cargos_id"], name: "index_usuarios_on_cargos_id"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["rols_id"], name: "index_usuarios_on_rols_id"
  end

  create_table "valor_leches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "tasa_cambio", precision: 10, scale: 2
    t.date "fecha"
  end

  add_foreign_key "antecedente_crediticios", "pagares"
  add_foreign_key "comprobante_detalles", "comprobantes"
  add_foreign_key "comprobante_detalles", "forma_pagos"
  add_foreign_key "comprobantes", "pagares"
  add_foreign_key "comprobantes", "socios"
  add_foreign_key "comprobantes", "tipo_monedas"
  add_foreign_key "comprobantes", "usuarios"
  add_foreign_key "cuotas", "pagares"
  add_foreign_key "fiadors", "estado_civils"
  add_foreign_key "fiadors", "socios"
  add_foreign_key "forma_pagos", "bancos", column: "bancos_id"
  add_foreign_key "forma_pagos", "tipo_monedas"
  add_foreign_key "forma_pagos", "tipo_pagos"
  add_foreign_key "pagares", "interes", column: "interes_id"
  add_foreign_key "pagares", "plazos"
  add_foreign_key "pagares", "socios"
  add_foreign_key "pagares", "tipo_monedas"
  add_foreign_key "pagares", "usuarios"
  add_foreign_key "recursos", "tipo_recursos"
  add_foreign_key "referencia_personal_pagares", "pagares"
  add_foreign_key "rol_accions", "accions"
  add_foreign_key "rol_accions", "recursos"
  add_foreign_key "rol_accions", "rols"
  add_foreign_key "socios", "escolaridads"
  add_foreign_key "socios", "estado_civils"
  add_foreign_key "socios", "sexos"
  add_foreign_key "socios", "tipo_domicilios"
  add_foreign_key "usuarios", "cargos", column: "cargos_id"
  add_foreign_key "usuarios", "rols", column: "rols_id"
end
