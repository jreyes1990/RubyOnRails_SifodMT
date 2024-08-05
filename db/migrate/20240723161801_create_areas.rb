class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas, id: false, comment: "Catálogo de Áreas por Empresa" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.references :empresa, null: false, foreign_key: false, index: false, comment: "Identificador de la empresa"
      t.integer :codigo_area, comment: "Identificador del código del área"
      t.string :nombre, limit: 100, null: false, comment: "Nombre del área"
      t.string :descripcion, comment: "Descripción general del área"
      t.string :codigo_hex, null: true, default: "#232323", comment: "Identificador del color codigo hexadecimal para el área"
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table areas add
        constraint pk_area
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :areas, :empresas, column: :empresa_id, name: 'fk_area_empresa'

    # Agregar el índice único con el nombre personalizado
    add_index :areas, [:empresa_id], name: "idx_area", unique: false

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table areas add
        constraint ck_estado_area
        check (estado in ('A', 'I'))
    SQL
  end
end
