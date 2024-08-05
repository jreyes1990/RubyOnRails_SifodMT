class CreateDetalleDatosExternos < ActiveRecord::Migration[6.0]
  def change
    create_table :detalle_datos_externos do |t|
      t.references :datos_externo, null: false, foreign_key: true
      t.string :nombre
      t.string :param1
      t.string :param2
      t.string :param3
      t.string :param4
      t.string :param5
      t.string :tipo
      t.string :body
      t.string :estado
      t.integer :user_created_id
      t.integer :user_updated_id

      t.timestamps
    end
  end
end
