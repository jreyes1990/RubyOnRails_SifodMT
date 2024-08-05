class CreateBitacoraConsultaMovils < ActiveRecord::Migration[6.0]
  def change
    create_table :bitacora_consulta_movils do |t|
      t.references :persona, null: false, foreign_key: true
      t.string :email
      t.string :accion
      t.string :descripcion
      t.string :fecha
      t.string :hora

      t.timestamps
    end
  end
end
