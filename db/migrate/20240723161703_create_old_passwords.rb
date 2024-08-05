class CreateOldPasswords < ActiveRecord::Migration[6.0]
  def change
    create_table :old_passwords do |t|
      t.string :encrypted_password, null: false
      t.references :password_archivable, polymorphic: true, index: { name: 'idx_old_passwords' }
      t.datetime :created_at
    end
  end
end
