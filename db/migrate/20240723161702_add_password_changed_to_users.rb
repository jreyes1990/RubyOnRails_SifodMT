class AddPasswordChangedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_changed, :boolean, default: false
    add_column :users, :password_changed_at, :datetime
  end
end
