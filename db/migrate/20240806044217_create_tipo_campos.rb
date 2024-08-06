class CreateTipoCampos < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_campos, id: false, comment: "Catálogo de tipos de campo" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.references :tipo_seleccion, null: true, foreign_key: false, index: false, comment: "Identificador del tipo de selección"
      t.references :tipo_contenido, null: true, foreign_key: false, index: false, comment: "Identificador del tipo de contenido"
      t.string :nombre, limit: 100, null: false, comment: "Nombre de tipo de campo"
      t.string :tipo_dato, limit: 25, null: false, comment: "Identifica el tipo de campo"
      t.string :descripcion, limit: 200, null: true, comment: "Descripción general del tipo de campo"
      t.boolean :tiene_respuesta, null: false, default: false, comment: "Identifica si el tipo de campo tendrá una configuración de respuesta"
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
      alter table tipo_campos add
        constraint pk_tipo_campo
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :tipo_campos, :tipo_selecciones, column: :tipo_seleccion_id, name: 'fk_tipoCampo_tipoSeleccion'
    add_foreign_key :tipo_campos, :tipo_contenidos, column: :tipo_contenido_id, name: 'fk_tipoCampo_tipoContenido'

    # Agregar el índice único con el nombre personalizado
    add_index :tipo_campos, [:tipo_seleccion_id, :tipo_contenido_id], name: "idx_tipoCampo", unique: false

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table tipo_campos add
        constraint ck_estado_tipoCampo
        check (estado in ('A', 'I'))
    SQL

    execute <<-SQL
      alter table tipo_campos add
        constraint ck_tieneRespuesta_tipoCampo
        check (tiene_respuesta in (true, false))
    SQL

    # Agregar el valores default de registro/actualizacion de usuario en base de datos
    execute <<-SQL
      ALTER TABLE tipo_campos
      ALTER COLUMN usr_grab SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL

    execute <<-SQL
      ALTER TABLE tipo_campos
      ALTER COLUMN usr_modi SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL
  end
end
