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

ActiveRecord::Schema.define(version: 2024_08_06_204759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", id: :serial, comment: "Catálogo de Áreas por Empresa", force: :cascade do |t|
    t.bigint "empresa_id", null: false, comment: "Identificador de la empresa"
    t.integer "codigo_area", comment: "Identificador del código del área"
    t.string "nombre", limit: 100, null: false, comment: "Nombre del área"
    t.string "descripcion", comment: "Descripción general del área"
    t.string "codigo_hex", default: "#232323", comment: "Identificador del color codigo hexadecimal para el área"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["empresa_id"], name: "idx_area"
  end

  create_table "atributos", id: :serial, comment: "Catálogo de Atributos", force: :cascade do |t|
    t.string "nombre", limit: 100, null: false, comment: "Nombre del atributo"
    t.string "descripcion", comment: "Descripción general del atributo"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "bitacora_autenticacion_movils", force: :cascade do |t|
    t.integer "persona_id"
    t.string "email"
    t.string "accion"
    t.string "descripcion"
    t.string "fecha"
    t.string "hora"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bitacora_consulta_movils", force: :cascade do |t|
    t.bigint "persona_id", null: false
    t.string "email"
    t.string "accion"
    t.string "descripcion"
    t.string "fecha"
    t.string "hora"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["persona_id"], name: "index_bitacora_consulta_movils_on_persona_id"
  end

  create_table "bitacora_token_personas", force: :cascade do |t|
    t.bigint "persona_id", null: false
    t.string "accion"
    t.string "descripcion"
    t.string "fecha"
    t.string "hora"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["persona_id"], name: "index_bitacora_token_personas_on_persona_id"
  end

  create_table "componentes", id: :serial, comment: "Catálogo de Componentes", force: :cascade do |t|
    t.string "nombre", limit: 100, null: false, comment: "Nombre del componente"
    t.string "descripcion", comment: "Descripción general del componente"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "datos_apis", force: :cascade do |t|
    t.string "nombre"
    t.string "url_api"
    t.string "token"
    t.string "estado"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "datos_externos", force: :cascade do |t|
    t.string "nombre"
    t.string "url_api"
    t.string "token"
    t.string "estado"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "detalle_datos_apis", force: :cascade do |t|
    t.bigint "datos_api_id", null: false
    t.string "nombre"
    t.string "param1"
    t.string "param2"
    t.string "param3"
    t.string "param4"
    t.string "param5"
    t.string "tipo"
    t.string "body"
    t.string "estado"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["datos_api_id"], name: "index_detalle_datos_apis_on_datos_api_id"
  end

  create_table "detalle_datos_externos", force: :cascade do |t|
    t.bigint "datos_externo_id", null: false
    t.string "nombre"
    t.string "param1"
    t.string "param2"
    t.string "param3"
    t.string "param4"
    t.string "param5"
    t.string "tipo"
    t.string "body"
    t.string "estado"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["datos_externo_id"], name: "index_detalle_datos_externos_on_datos_externo_id"
  end

  create_table "empresas", id: :serial, comment: "Catálogo de Empresas", force: :cascade do |t|
    t.integer "codigo_empresa", null: false, comment: "Identificador codigo de la empresa"
    t.string "nombre", limit: 100, null: false, comment: "Nombre de la empresa"
    t.string "descripcion", comment: "Descripción general de la empresa"
    t.string "codigo_hex", default: "#232323", comment: "Identificador del color codigo hexadecimal para la empresa"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "menu_roles", id: :serial, comment: "Catálogo Configuración de Menú por Roles", force: :cascade do |t|
    t.bigint "menu_id", null: false, comment: "Identificador del menú"
    t.bigint "opcion_id", null: false, comment: "Identificador de la opción por menú"
    t.bigint "rol_id", null: false, comment: "Identificador del rol"
    t.string "descripcion", comment: "Descripción general del menú por rol"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["menu_id", "opcion_id", "rol_id"], name: "idx_menuRol"
  end

  create_table "menus", id: :serial, comment: "Catálogo de Menú", force: :cascade do |t|
    t.string "nombre", limit: 100, null: false, comment: "Nombre del menú"
    t.string "descripcion", comment: "Descripción general del menú"
    t.string "icono", limit: 50, null: false, comment: "Identificador de icono para el menú"
    t.string "codigo_hex", default: "#232323", comment: "Identificador de color, codigo hexadecimal para el menú"
    t.string "menu_sidebar", comment: "Identificador del menú a utilizar en el sidebar"
    t.boolean "visible_sidebar", default: true, null: false, comment: "El menú será visible en el sidebar?"
    t.integer "posicion", comment: "Orden del menú a utilizar en el sidebar"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_archivable_type"
    t.bigint "password_archivable_id"
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "idx_old_passwords"
  end

  create_table "opcion_cas", id: :serial, comment: "Módulo Configuración de Opcion-Componente-Atributo", force: :cascade do |t|
    t.bigint "opcion_id", null: false, comment: "Identificador de la opción por opcion_cas"
    t.bigint "componente_id", null: false, comment: "Identificador del componente por opcion_cas"
    t.bigint "atributo_id", null: false, comment: "Identificador del atributo por opcion_cas"
    t.string "descripcion", comment: "Descripción general de la opción_ca"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["opcion_id", "componente_id", "atributo_id"], name: "idx_opcionCa"
  end

  create_table "opciones", id: :serial, comment: "Catálogo de Opciones por Menú", force: :cascade do |t|
    t.bigint "menu_id", null: false, comment: "Identificador del menú"
    t.bigint "sub_opcion_id", null: false, comment: "Identificador de la sub-opción"
    t.string "nombre", limit: 100, null: false, comment: "Nombre de la opción"
    t.string "descripcion", comment: "Descripción general de la opción"
    t.string "icono", limit: 50, comment: "Icono que identificará la opción"
    t.string "path", null: false, comment: "Identificador de ruta de navegación"
    t.string "controlador", limit: 300, null: false, comment: "Identificador de controlador de navegación"
    t.string "codigo_hex", default: "#232323", comment: "Color Hexadecimal que identificará la opción"
    t.string "componente_sidebar", comment: "Identificador el componente a utilizar en el sidebar"
    t.boolean "visible_sidebar", default: true, null: false, comment: "El componente será visible en el sidebar?"
    t.integer "posicion", comment: "Orden del componente a utilizar en el sidebar"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["menu_id", "sub_opcion_id"], name: "idx_opcion"
  end

  create_table "parametros", id: :serial, comment: "Módulo Configuración de parametros de usuario", force: :cascade do |t|
    t.bigint "empresa_id", null: false, comment: "Identificador de la empresa"
    t.bigint "area_id", null: false, comment: "Identificador del área"
    t.bigint "user_id", null: false, comment: "Identificador del usuario"
    t.string "nombre_area"
    t.string "nombre_empresa"
    t.string "ruta_predeterminada"
    t.string "view_default"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["empresa_id", "area_id", "user_id"], name: "idx_parametro"
  end

  create_table "persona_empresa_formularios", id: :serial, comment: "Módulo Configuración de (Persona-Área)-(Opcion-Componente-Atributo)", force: :cascade do |t|
    t.bigint "personas_area_id", null: false, comment: "Identificador de la persona por área"
    t.bigint "opcion_ca_id", null: false, comment: "Identificador de opcion_cas"
    t.string "descripcion", comment: "Descripción general de la persona empresa formulario"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["personas_area_id", "opcion_ca_id"], name: "idx_pEmpForm"
  end

  create_table "personas", id: :serial, comment: "Módulo Configuración de Usuarios", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "Identificador del usuario"
    t.string "nombre", limit: 100, null: false, comment: "Nombre de la persona"
    t.string "apellido", limit: 100, null: false, comment: "Apellido de la persona"
    t.text "foto", comment: "Foto de la persona"
    t.bigint "telefono", default: 0, null: false, comment: "Número de celular de la persona"
    t.integer "chat_id_telegram", comment: "Identificador del ID Telegram"
    t.string "direccion"
    t.string "token", limit: 1000
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["user_id"], name: "idx_persona"
  end

  create_table "personas_areas", id: :serial, comment: "Módulo Configuración de Persona-Área-Rol", force: :cascade do |t|
    t.bigint "persona_id", null: false, comment: "Identificador de la persona"
    t.bigint "area_id", null: false, comment: "Identificador del área"
    t.bigint "rol_id", comment: "Identificador del rol"
    t.string "descripcion", comment: "Descripción general de la persona por área"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["persona_id", "area_id", "rol_id"], name: "idx_personaArea"
  end

  create_table "roles", id: :serial, comment: "Catálogo de Roles", force: :cascade do |t|
    t.string "nombre", limit: 100, null: false, comment: "Nombre del rol"
    t.string "descripcion", comment: "Descripción general del rol"
    t.string "codigo_hex", default: "#232323", comment: "Color Hexadecimal que identificará el rol"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "sub_opciones", id: :serial, comment: "Catálogo de Sub-Opciones", force: :cascade do |t|
    t.string "nombre", limit: 100, default: "OPCIONES:", null: false, comment: "Nombre de la sub-opción"
    t.string "descripcion", comment: "Descripción general de la sub-opción"
    t.boolean "visible_sidebar", default: true, null: false, comment: "La sub-opción será visible en el sidebar?"
    t.integer "posicion", comment: "Orden de la sub-opción a utilizar en el sidebar"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "tipo_campos", id: :serial, comment: "Catálogo de tipos de campo", force: :cascade do |t|
    t.bigint "tipo_seleccion_id", comment: "Identificador del tipo de selección"
    t.bigint "tipo_contenido_id", comment: "Identificador del tipo de contenido"
    t.string "nombre", limit: 100, null: false, comment: "Nombre de tipo de campo"
    t.string "tipo_dato", limit: 25, null: false, comment: "Identifica el tipo de campo"
    t.string "descripcion", limit: 200, comment: "Descripción general del tipo de campo"
    t.boolean "tiene_respuesta", default: false, null: false, comment: "Identifica si el tipo de campo tendrá una configuración de respuesta"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "usr_grab", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al registrar en la base de datos"
    t.string "usr_modi", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al actualizar en la base de datos"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["tipo_seleccion_id", "tipo_contenido_id"], name: "idx_tipoCampo"
  end

  create_table "tipo_contenidos", id: :serial, comment: "Catálogo de tipos de contenido", force: :cascade do |t|
    t.string "nombre", limit: 100, null: false, comment: "Nombre de tipo de contenido"
    t.text "content_type", null: false, comment: "Identifica el tipo de archivo"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "usr_grab", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al registrar en la base de datos"
    t.string "usr_modi", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al actualizar en la base de datos"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "tipo_formularios", id: :serial, comment: "Catálogo de tipos de formulario", force: :cascade do |t|
    t.integer "empresa_id", null: false, comment: "Identifica el codigo de la empresa"
    t.integer "area_id", null: false, comment: "Identifica el codigo del área"
    t.string "nombre", limit: 100, null: false, comment: "Nombre de tipo de formulario"
    t.string "descripcion", limit: 200, comment: "Descripción general del tipo de formulario"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "usr_grab", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al registrar en la base de datos"
    t.string "usr_modi", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al actualizar en la base de datos"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["empresa_id", "area_id", "nombre"], name: "idx_tipoFormulario", unique: true
  end

  create_table "tipo_frecuencias", id: :serial, comment: "Catálogo de tipos de frecuencia", force: :cascade do |t|
    t.integer "empresa_id", null: false, comment: "Identifica el codigo de la empresa"
    t.string "nombre", limit: 100, null: false, comment: "Nombre de tipo de frecuencia"
    t.string "descripcion", limit: 200, comment: "Descripción general del tipo de frecuencia"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "usr_grab", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al registrar en la base de datos"
    t.string "usr_modi", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al actualizar en la base de datos"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
    t.index ["empresa_id", "nombre"], name: "idx_tipoFrecuencia", unique: true
  end

  create_table "tipo_selecciones", id: :serial, comment: "Catálogo de tipo de selección", force: :cascade do |t|
    t.string "nombre", limit: 100, null: false, comment: "Nombre del tipo de selección"
    t.boolean "valor", default: false, null: false, comment: "Identifica si la selección será multiple o simple"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "usr_grab", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al registrar en la base de datos"
    t.string "usr_modi", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al actualizar en la base de datos"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "unidad_medidas", id: :serial, comment: "Catálogo de unidad de medida por empresa", force: :cascade do |t|
    t.integer "empresa_id", null: false, comment: "Identificador de la empresa"
    t.integer "medida_id", null: false, comment: "Identificador de la unidad de medida"
    t.string "nombre", limit: 100, null: false, comment: "Nombre de la unidad de medida"
    t.string "abreviatura", limit: 10, null: false, comment: "Abreviatura de la unidad de medida"
    t.string "descripcion", limit: 200, comment: "Descripción general de la unidad de medida"
    t.integer "user_created_id", null: false, comment: "Identificador de usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador de usuario al actualizar en la aplicación web"
    t.string "usr_grab", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al registrar en la base de datos"
    t.string "usr_modi", limit: 50, default: -> { "((replace(upper((USER)::text), 'OPS$'::text, ''::text) || '-'::text) || to_char(CURRENT_TIMESTAMP, 'dd/mm/yyyy HH24:MI'::text))" }, comment: "Identificador de usuario al actualizar en la base de datos"
    t.string "estado", limit: 10, default: "A", null: false, comment: "Estados: [A]: Activo  [I]: Inactivo"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de creación del registro"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false, comment: "Fecha y hora de la última actualización del registro"
  end

  create_table "users", comment: "Catálogo de usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false, comment: "Corre electronico del usuario"
    t.string "encrypted_password", default: "", null: false, comment: "Password-Contraseña encriptada"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "user_created_id", comment: "Identificador del usuario al registrar en la aplicación web"
    t.integer "user_updated_id", comment: "Identificador del usuario al actualizar en la aplicación web"
    t.string "estado", default: "A", comment: "Estado del user: [A]: Activo;  [I]: Inactivo"
    t.datetime "created_at", precision: 6, null: false, comment: "Fecha y hora al registrar datos"
    t.datetime "updated_at", precision: 6, null: false, comment: "Fecha y hora al actualizar datos"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "password_changed", default: false
    t.datetime "password_changed_at"
    t.index ["email"], name: "uidx_email", unique: true
    t.index ["reset_password_token"], name: "uidx_resetPassToken", unique: true
  end

  add_foreign_key "areas", "empresas", name: "fk_area_empresa"
  add_foreign_key "bitacora_consulta_movils", "personas"
  add_foreign_key "bitacora_token_personas", "personas"
  add_foreign_key "detalle_datos_apis", "datos_apis"
  add_foreign_key "detalle_datos_externos", "datos_externos"
  add_foreign_key "menu_roles", "menus", name: "fk_menuRol_menu"
  add_foreign_key "menu_roles", "opciones", name: "fk_menuRol_opcion"
  add_foreign_key "menu_roles", "roles", name: "fk_menuRol_rol"
  add_foreign_key "opcion_cas", "atributos", name: "fk_opcionCa_atributo"
  add_foreign_key "opcion_cas", "componentes", name: "fk_opcionCa_componente"
  add_foreign_key "opcion_cas", "opciones", name: "fk_opcionCa_opcion"
  add_foreign_key "opciones", "menus", name: "fk_opcion_menu"
  add_foreign_key "opciones", "sub_opciones", name: "fk_opcion_subOpcion"
  add_foreign_key "parametros", "areas", name: "fk_parametro_area"
  add_foreign_key "parametros", "empresas", name: "fk_parametro_empresa"
  add_foreign_key "parametros", "users", name: "fk_parametro_user"
  add_foreign_key "persona_empresa_formularios", "opcion_cas", name: "fk_pEmpForm_opcionCa"
  add_foreign_key "persona_empresa_formularios", "personas_areas", name: "fk_pEmpForm_personArea"
  add_foreign_key "personas", "users", name: "fk_persona_user"
  add_foreign_key "personas_areas", "areas", name: "fk_personaArea_area"
  add_foreign_key "personas_areas", "personas", name: "fk_personaArea_persona"
  add_foreign_key "personas_areas", "roles", name: "fk_personaArea_rol"
  add_foreign_key "tipo_campos", "tipo_contenidos", name: "fk_tipoCampo_tipoContenido"
  add_foreign_key "tipo_campos", "tipo_selecciones", name: "fk_tipoCampo_tipoSeleccion"

  create_view "personas_areas_views", sql_definition: <<-SQL
      SELECT personas_areas.id,
      personas_areas.persona_id,
      personas_areas.area_id,
      personas_areas.rol_id,
      personas_areas.descripcion,
      personas_areas.user_created_id,
      personas_areas.user_updated_id,
      personas_areas.estado,
      personas_areas.created_at,
      personas_areas.updated_at,
      (((personas.nombre)::text || ' '::text) || (personas.apellido)::text) AS nombre_usuario,
      personas.telefono AS telefono_usuario,
      personas.user_id,
      users.email AS email_usuario,
      areas.codigo_area,
      areas.nombre AS nombre_area,
      areas.codigo_hex AS codigo_hex_area,
      areas.empresa_id,
      empresas.codigo_empresa,
      empresas.nombre AS nombre_empresa,
      roles.nombre AS nombre_rol,
      roles.codigo_hex AS codigo_hex_rol
     FROM (((((personas_areas
       JOIN personas ON ((personas_areas.persona_id = personas.id)))
       JOIN users ON ((personas.user_id = users.id)))
       JOIN areas ON ((personas_areas.area_id = areas.id)))
       JOIN empresas ON ((areas.empresa_id = empresas.id)))
       LEFT JOIN roles ON ((personas_areas.rol_id = roles.id)));
  SQL
  create_view "opcion_cas_views", sql_definition: <<-SQL
      SELECT oc.id,
      o.nombre AS opcion,
      c.nombre AS componente,
      a.nombre AS atributo,
      oc.descripcion,
      oc.estado
     FROM (((opcion_cas oc
       JOIN opciones o ON ((o.id = oc.opcion_id)))
       JOIN componentes c ON ((c.id = oc.componente_id)))
       JOIN atributos a ON ((a.id = oc.atributo_id)))
    WHERE ((oc.estado)::text = 'A'::text)
    ORDER BY oc.id;
  SQL
end
