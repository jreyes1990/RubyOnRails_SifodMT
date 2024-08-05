# == Schema Information
#
# Table name: opciones
#
#  id              :integer          not null, primary key
#  nombre          :string(255)
#  descripcion     :string(255)
#  icono           :string(255)
#  path            :string(255)
#  controlador     :string(255)
#  menu_id         :integer          not null
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Opcion < ApplicationRecord
  belongs_to :menu
  belongs_to :sub_opcion
  
  has_many :menu_roles
  has_many :opcion_cas

  validates_presence_of :nombre, :menu_id, :descripcion, :icono, :path, :controlador, message: ": este campo es obligatorio"
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" } 
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:menu_id, :path, :controlador, :estado], message: "El nombre que intenta registrar ya existe" } 

  def nombre_con_menu
    "#{self.menu.nombre} - #{self.nombre}"
  end

  def opcion_nombre_id
    "#{self.id}-#{self.nombre}"
  end

end
