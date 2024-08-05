class CreateSubOpciones < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_opciones, id: false, comment: "Catálogo de Sub-Opciones" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.string :nombre, limit: 100, null: false, default: "OPCIONES:", comment: "Nombre de la sub-opción"
      t.string :descripcion, null: true, comment: "Descripción general de la sub-opción"
      t.boolean :visible_sidebar, null: false, default: true, comment: "La sub-opción será visible en el sidebar?"
      t.integer :posicion, null: true, comment: "Orden de la sub-opción a utilizar en el sidebar"
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"  

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table sub_opciones add
        constraint pk_subOpcion
        primary key (id)
    SQL

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table sub_opciones add
        constraint ck_estado_subOpcion
        check (estado in ('A', 'I'))
    SQL
  end
end
