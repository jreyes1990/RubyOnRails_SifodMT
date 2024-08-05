class CreateDatosApis < ActiveRecord::Migration[6.0]
  def change
    create_table :datos_apis do |t|
      t.string :nombre
      t.string :url_api
      t.string :token
      t.string :estado
      t.integer :user_created_id
      t.integer :user_updated_id

      t.timestamps
    end
  end
end
