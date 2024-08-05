class CreatePersonas < ActiveRecord::Migration[6.0]
  def change
    create_table :personas, id: false, comment: "Módulo Configuración de Usuarios" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.references :user, null: false, foreign_key: false, index: false, comment: "Identificador del usuario" 
      t.string :nombre, limit: 100, null: false, comment: "Nombre de la persona"
      t.string :apellido, limit: 100, null: false, comment: "Apellido de la persona"
      t.text :foto, null: true, comment: "Foto de la persona"
      t.integer :telefono, limit: 8, null: false, default: 00000000, comment: "Número de celular de la persona"
      t.integer :chat_id_telegram, null: true, comment: "Identificador del ID Telegram"
      t.string :direccion  
      t.string :token, limit: 1000
      t.integer :user_created_id, null: false, comment: "Identificador de usuario al registrar en la aplicación web"
      t.integer :user_updated_id, null: true, comment: "Identificador de usuario al actualizar en la aplicación web"
      t.string :estado, limit: 10, null: false, default: "A", comment: "Estados: [A]: Activo  [I]: Inactivo"      

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table personas add
        constraint pk_persona
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :personas, :users, column: :user_id, name: 'fk_persona_user'

    # Agregar el índice único con el nombre personalizado
    add_index :personas, [:user_id], name: "idx_persona", unique: false

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table personas add
        constraint ck_estado_persona
        check (estado in ('A', 'I'))
    SQL
  end
end
