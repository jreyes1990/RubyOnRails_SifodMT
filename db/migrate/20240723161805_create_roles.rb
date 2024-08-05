class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles, id: false, comment: "Catálogo de Roles" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.string :nombre, limit: 100, null: false, comment: "Nombre del rol"
      t.string :descripcion, null: true, comment: "Descripción general del rol" 
      t.string :codigo_hex, null: true, default: "#232323", comment: "Color Hexadecimal que identificará el rol"           
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"  

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table roles add
        constraint pk_rol
        primary key (id)
    SQL

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table roles add
        constraint ck_estado_rol
        check (estado in ('A', 'I'))
    SQL
  end
end
