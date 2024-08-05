class CreateBitacoraAutenticacionMovils < ActiveRecord::Migration[6.0]
  def change
    create_table :bitacora_autenticacion_movils do |t|
      t.integer :persona_id
      t.string :email
      t.string :accion
      t.string :descripcion
      t.string :fecha
      t.string :hora

      t.timestamps
    end
  end
end
