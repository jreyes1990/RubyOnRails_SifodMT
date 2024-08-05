# == Schema Information
#
# Table name: menu_roles
#
#  id              :integer          not null, primary key
#  rol_id          :integer          not null
#  opcion_id       :integer          not null
#  menu_padre      :integer
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class MenuRol < ApplicationRecord
  belongs_to :rol
  belongs_to :opcion
  belongs_to :menu

  validates :rol_id, :opcion_id, :menu_id, presence: true
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates_uniqueness_of :rol_id, :scope => [:opcion_id, :menu_id], :message => " error!! solo puede asignar una la opcion al rol"  
  
end
