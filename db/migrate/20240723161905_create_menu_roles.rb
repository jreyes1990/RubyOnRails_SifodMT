class CreateMenuRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_roles, id: false, comment: "Catálogo Configuración de Menú por Roles" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.references :menu, null: false, foreign_key: false, index: false, comment: "Identificador del menú"
      t.references :opcion, null: false, foreign_key: false, index: false, comment: "Identificador de la opción por menú" 
      t.references :rol, null: false, foreign_key: false, index: false, comment: "Identificador del rol"
      t.string :descripcion, null: true, comment: "Descripción general del menú por rol"          
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"  

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table menu_roles add
        constraint pk_menu_rol
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :menu_roles, :menus, column: :menu_id, name: 'fk_menuRol_menu'
    add_foreign_key :menu_roles, :opciones, column: :opcion_id, name: 'fk_menuRol_opcion'
    add_foreign_key :menu_roles, :roles, column: :rol_id, name: 'fk_menuRol_rol'

    # Agregar el índice único con el nombre personalizado
    add_index :menu_roles, [:menu_id, :opcion_id, :rol_id], name: "idx_menuRol", unique: false

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table menu_roles add
        constraint ck_estado_menuRol
        check (estado in ('A', 'I'))
    SQL
  end
end
