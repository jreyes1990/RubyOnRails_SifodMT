class CreateTipoFormularios < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_formularios, id: false, comment: "Catálogo de tipos de formulario" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.integer :empresa_id, null: false, comment: "Identifica el codigo de la empresa"
      t.integer :area_id, null: false, comment: "Identifica el codigo del área"
      t.string :nombre, limit: 100, null: false, comment: "Nombre de tipo de formulario"
      t.string :tipo_datascope, limit: 100, null: true, comment: "Identificada el tipo de datascope a utilizar"
      t.string :descripcion, limit: 200, null: true, comment: "Descripción general del tipo de formulario"
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :usr_grab, limit: 50, null: true, comment: "Identificador de usuario al registrar en la base de datos"
      t.string :usr_modi, limit: 50, null: true, comment: "Identificador de usuario al actualizar en la base de datos"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table tipo_formularios add
        constraint pk_tipo_formulario
        primary key (id)
    SQL

    # Agregar el índice único con el nombre personalizado
    add_index :tipo_formularios, [:empresa_id, :area_id, :nombre], name: "idx_tipoFormulario", unique: true

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table tipo_formularios add
        constraint ck_tipoDatScop_tipoFormulario
        check (tipo_datascope in ('DATASCOPE_CHECK_LIST', 'DATASCOPE_CALIDAD'))
    SQL

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table tipo_formularios add
        constraint ck_estado_tipoFormulario
        check (estado in ('A', 'I'))
    SQL

    # Agregar el valores default de registro/actualizacion de usuario en base de datos
    execute <<-SQL
      ALTER TABLE tipo_formularios
      ALTER COLUMN usr_grab SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL

    execute <<-SQL
      ALTER TABLE tipo_formularios
      ALTER COLUMN usr_modi SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL
  end
end
