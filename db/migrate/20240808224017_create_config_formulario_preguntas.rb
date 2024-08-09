class CreateConfigFormularioPreguntas < ActiveRecord::Migration[6.0]
  def change
    create_table :config_formulario_preguntas, id: false, comment: "Módulo configuración de preguntas por formulario" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.integer :empresa_id, null: false, comment: "Identifica el codigo de la empresa"
      t.integer :area_id, null: false, comment: "Identifica el codigo del área"
      t.references :config_formulario, null: false, foreign_key: false, index: false, comment: "Identifica el codigo de configuración de formulario" 
      t.references :config_pregunta, null: false, foreign_key: false, index: false, comment: "Identifica el codigo de configuración de la pregunta" 
      t.references :config_sub_pregunta, null: true, foreign_key: false, index: false, comment: "Identifica el codigo de configuración de la sub-pregunta" 
      t.references :unidad_medida, null: true, foreign_key: false, index: false, comment: "Identifica el codigo de la unidad de medida" 
      t.boolean :requerido, null: true, default: false, comment: "¿La pregunta tendrá una respuesta obligatoria?"
      t.integer :posicion
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
      alter table config_formulario_preguntas add
        constraint pk_cfgFormPregunta
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :config_formulario_preguntas, :config_formularios, column: :config_formulario_id, name: 'fk_cfgFormPreg_cfgForm'
    add_foreign_key :config_formulario_preguntas, :config_preguntas, column: :config_pregunta_id, name: 'fk_cfgFormPreg_cfgPreg'
    add_foreign_key :config_formulario_preguntas, :config_sub_preguntas, column: :config_sub_pregunta_id, name: 'fk_cfgFormPreg_cfgSubPreg'
    add_foreign_key :config_formulario_preguntas, :unidad_medidas, column: :unidad_medida_id, name: 'fk_cfgFormPreg_unidadMedida'

    # Agregar el índice único con el nombre personalizado
    add_index :config_formulario_preguntas, [:empresa_id, :area_id, :config_formulario_id, :config_pregunta_id, :config_sub_pregunta_id, :unidad_medida_id], name: "idx_cfgFormPreg", unique: true

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table config_formulario_preguntas add
        constraint ck_requerido_cfgFormPreg
        check (requerido in (true, false))
    SQL

    execute <<-SQL
      alter table config_formulario_preguntas add
        constraint ck_estado_cfgFormPreg
        check (estado in ('A', 'I'))
    SQL

    # Agregar el valores default de registro/actualizacion de usuario en base de datos
    execute <<-SQL
      ALTER TABLE config_formulario_preguntas
      ALTER COLUMN usr_grab SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL

    execute <<-SQL
      ALTER TABLE config_formulario_preguntas
      ALTER COLUMN usr_modi SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL
  end
end
