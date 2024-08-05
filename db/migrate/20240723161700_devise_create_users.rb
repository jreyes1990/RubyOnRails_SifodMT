# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "", comment: "Corre electronico del usuario"
      t.string :encrypted_password, null: false, default: "", comment: "Password-Contraseña encriptada"

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

            
      t.integer :user_created_id, comment: "Identificador del usuario al registrar en la aplicación web"
      t.integer :user_updated_id, comment: "Identificador del usuario al actualizar en la aplicación web"
      t.string :estado, default: "A", comment: "Estado del user: [A]: Activo;  [I]: Inactivo"  
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true, name: "uidx_email"
    add_index :users, :reset_password_token, unique: true, name: "uidx_resetPassToken"
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

    # Agregar el constraint CHECK sin el punto y coma al final
    execute <<-SQL
      alter table users add
        constraint ck_estado_usuario
        check (estado in ('A', 'I'))
    SQL

    # Agregar comentarios a la tabla
    execute <<-SQL
      comment on table users is 'Catálogo de usuarios'
    SQL

    # Agregar comentarios a las columnas
    execute <<-SQL
      comment on column users.id is 'Identificador de la llave primaria'
    SQL

    execute <<-SQL
      comment on column users.created_at is 'Fecha y hora al registrar datos'
    SQL

    execute <<-SQL
      comment on column users.updated_at is 'Fecha y hora al actualizar datos'
    SQL
  end
end
