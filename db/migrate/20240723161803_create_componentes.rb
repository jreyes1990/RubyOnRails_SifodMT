class CreateComponentes < ActiveRecord::Migration[6.0]
  def change
    create_table :componentes, id: false, comment: "Catálogo de Componentes" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.string :nombre, limit: 100, null: false, comment: "Nombre del componente"
      t.string :descripcion, comment: "Descripción general del componente"            
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"  

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table componentes add
        constraint pk_componente
        primary key (id)
    SQL

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table componentes add
        constraint ck_estado_componente
        check (estado in ('A', 'I'))
    SQL
  end
end
