class CreateOpcionCas < ActiveRecord::Migration[6.0]
  def change
    create_table :opcion_cas, id: false, comment: "Módulo Configuración de Opcion-Componente-Atributo" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.references :opcion, null: false, foreign_key: false, index: false, comment: "Identificador de la opción por opcion_cas" 
      t.references :componente, null: false, foreign_key: false, index: false, comment: "Identificador del componente por opcion_cas" 
      t.references :atributo, null: false, foreign_key: false, index: false, comment: "Identificador del atributo por opcion_cas" 
      t.string :descripcion, null: true, comment: "Descripción general de la opción_ca"            
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"    

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table opcion_cas add
        constraint pk_opcionCa
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :opcion_cas, :opciones, column: :opcion_id, name: 'fk_opcionCa_opcion'
    add_foreign_key :opcion_cas, :componentes, column: :componente_id, name: 'fk_opcionCa_componente'
    add_foreign_key :opcion_cas, :atributos, column: :atributo_id, name: 'fk_opcionCa_atributo'

    # Agregar el índice único con el nombre personalizado
    add_index :opcion_cas, [:opcion_id, :componente_id, :atributo_id], name: "idx_opcionCa", unique: false

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table opcion_cas add
        constraint ck_estado_opcionCa
        check (estado in ('A', 'I'))
    SQL
  end
end
