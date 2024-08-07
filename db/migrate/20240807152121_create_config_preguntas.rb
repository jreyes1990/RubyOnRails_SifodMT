class CreateConfigPreguntas < ActiveRecord::Migration[6.0]
  def change
    create_table :config_preguntas, id: false, comment: "Módulo configuración de preguntas" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.integer :empresa_id, null: false, comment: "Identifica el codigo de la empresa"
      t.integer :area_id, null: false, comment: "Identifica el codigo del área"
      t.references :tipo_campo, null: false, foreign_key: false, index: false, comment: "Identifica el codigo tipo de campo" 
      t.string :nombre, limit: 100, null: false, comment: "Nombre de la configuración pregunta"
      t.string :descripcion, limit: 200, null: true, comment: "Descripción general de la configuración pregunta"
      t.boolean :tiene_parametro, null: true, default: false, comment: "¿La pregunta tendrá párametros esperados?"
      t.boolean :tiene_sub_pregunta, null: true, default: false, comment: "¿La pregunta tendrá configuración de sub-preguntas?"
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
      alter table config_preguntas add
        constraint pk_cfgPregunta
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :config_preguntas, :tipo_campos, column: :tipo_campo_id, name: 'fk_cfgPregunta_tipoCampo'

    # Agregar el índice único con el nombre personalizado
    add_index :config_preguntas, [:empresa_id, :area_id, :tipo_campo_id, :nombre], name: "idx_cfgPregunta", unique: true

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table config_preguntas add
        constraint ck_tieneParam_cfgPregunta
        check (tiene_parametro in (true, false))
    SQL

    execute <<-SQL
      alter table config_preguntas add
        constraint ck_tieneSubPreg_cfgPregunta
        check (tiene_sub_pregunta in (true, false))
    SQL

    execute <<-SQL
      alter table config_preguntas add
        constraint ck_estado_cfgPregunta
        check (estado in ('A', 'I'))
    SQL

    # Agregar el valores default de registro/actualizacion de usuario en base de datos
    execute <<-SQL
      ALTER TABLE config_preguntas
      ALTER COLUMN usr_grab SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL

    execute <<-SQL
      ALTER TABLE config_preguntas
      ALTER COLUMN usr_modi SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL
  end
end
