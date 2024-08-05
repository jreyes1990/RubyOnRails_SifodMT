class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus, id: false, comment: "Catálogo de Menú" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.string :nombre, limit: 100, null: false, comment: "Nombre del menú"
      t.string :descripcion, null: true, comment: "Descripción general del menú"
      t.string :icono, limit: 50, null: false, comment: "Identificador de icono para el menú"
      t.string :codigo_hex, null: true, default: "#232323", comment: "Identificador de color, codigo hexadecimal para el menú"
      t.string :menu_sidebar, null: true, comment: "Identificador del menú a utilizar en el sidebar"
      t.boolean :visible_sidebar, null: false, default: true, comment: "El menú será visible en el sidebar?"
      t.integer :posicion, null: true, comment: "Orden del menú a utilizar en el sidebar"
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"  

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table menus add
        constraint pk_menu
        primary key (id)
    SQL

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table menus add
        constraint ck_estado_menu
        check (estado in ('A', 'I'))
    SQL
  end
end
