class CreateBitacoraTokenPersonas < ActiveRecord::Migration[6.0]
  def change
    create_table :bitacora_token_personas do |t|
      t.references :persona, null: false, foreign_key: true
      t.string :accion
      t.string :descripcion
      t.string :fecha
      t.string :hora

      t.timestamps
    end
  end
end
