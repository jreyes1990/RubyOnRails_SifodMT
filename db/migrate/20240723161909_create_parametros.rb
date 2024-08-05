class CreateParametros < ActiveRecord::Migration[6.0]
  def change
    create_table :parametros, id: false, comment: "Módulo Configuración de parametros de usuario" do |t|
      t.serial :id, null: false, comment: "Identificador de la llave primaria"
      t.references :empresa, null: false, foreign_key: false, index: false, comment: "Identificador de la empresa" 
      t.references :area, null: false, foreign_key: false, index: false, comment: "Identificador del área" 
      t.references :user, null: false, foreign_key: false, index: false, comment: "Identificador del usuario" 
      t.string :nombre_area
      t.string :nombre_empresa
      t.string :ruta_predeterminada
      t.string :view_default

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de creación del registro"
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }, comment: "Fecha y hora de la última actualización del registro"
      # t.timestamps
    end

    # Crear el índice y la restricción de clave primaria con un nombre específico
    execute <<-SQL
      alter table parametros add
        constraint pk_parametro
        primary key (id)
    SQL

    # Agregar la clave foránea con el nombre personalizado
    add_foreign_key :parametros, :empresas, column: :empresa_id, name: 'fk_parametro_empresa'
    add_foreign_key :parametros, :areas, column: :area_id, name: 'fk_parametro_area'
    add_foreign_key :parametros, :users, column: :user_id, name: 'fk_parametro_user'

    # Agregar el índice único con el nombre personalizado
    add_index :parametros, [:empresa_id, :area_id, :user_id], name: "idx_parametro", unique: false
  end
end
