class CreatePersonasAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :personas_areas, id: false, comment: "Módulo Configuración de Persona-Área-Rol" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.references :persona, null: false, foreign_key: false, index: false, comment: "Identificador de la persona" 
      t.references :area, null: false, foreign_key: false, index: false, comment: "Identificador del área" 
      t.references :rol, null: true, foreign_key: false, index: false, comment: "Identificador del rol" 
      t.string :descripcion, null: true, comment: "Descripción general de la persona por área"
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"    

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table personas_areas add
        constraint pk_personaArea
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :personas_areas, :personas, column: :persona_id, name: 'fk_personaArea_persona'
    add_foreign_key :personas_areas, :areas, column: :area_id, name: 'fk_personaArea_area'
    add_foreign_key :personas_areas, :roles, column: :rol_id, name: 'fk_personaArea_rol'

    # Agregar el índice único con el nombre personalizado
    add_index :personas_areas, [:persona_id, :area_id, :rol_id], name: "idx_personaArea", unique: false

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table personas_areas add
        constraint ck_estado_personaArea
        check (estado in ('A', 'I'))
    SQL
  end
end
