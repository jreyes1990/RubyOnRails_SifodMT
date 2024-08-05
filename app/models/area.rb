# == Schema Information
#
# Table name: areas
#
#  id              :integer          not null, primary key
#  nombre          :string(255)
#  descripcion     :string(255)
#  codigo_area     :string(255)
#  empresa_id      :integer          not null
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Area < ApplicationRecord
  belongs_to :empresa

  validates :nombre, :descripcion, :empresa_id, :user_created_id, presence: true
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:empresa_id, :estado], message: "El dato que intenta registrar ya existe, Verifique!!!" }


  def nombre_area_empresa
    "#{self.empresa.nombre.upcase} - #{self.nombre.upcase}"
  end

  def nombre_con_codigo
    "#{self.id} | ÁREA: #{self.nombre.upcase}"
  end

  def area_con_codigo
    "#{self.codigo_area} | #{self.nombre.upcase}"
  end

end
