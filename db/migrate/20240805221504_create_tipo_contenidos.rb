class CreateTipoContenidos < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_contenidos, id: false, comment: "Catálogo de tipos de contenido" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.string :nombre, limit: 100, null: false, comment: "Nombre de tipo de contenido"
      t.text :content_type, null: false, comment: "Identifica el tipo de archivo"
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
      alter table tipo_contenidos add
        constraint pk_tipo_contenido
        primary key (id)
    SQL

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table tipo_contenidos add
        constraint ck_estado_tipoContenido
        check (estado in ('A', 'I'))
    SQL

    # Agregar el valores default de registro/actualizacion de usuario en base de datos
    execute <<-SQL
      ALTER TABLE tipo_contenidos
      ALTER COLUMN usr_grab SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL

    execute <<-SQL
      ALTER TABLE tipo_contenidos
      ALTER COLUMN usr_modi SET DEFAULT replace(upper(user),'OPS$','') || '-' || to_char(CURRENT_TIMESTAMP,'dd/mm/yyyy HH24:MI');
    SQL
  end
end
