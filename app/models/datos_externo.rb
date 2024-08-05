# == Schema Information
#
# Table name: datos_externos
#
#  id              :integer          not null, primary key
#  nombre          :string(255)
#  url_api         :string(255)
#  token           :string(255)
#  estado          :string(255)
#  user_created_id :integer
#  user_updated_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class DatosExterno < ApplicationRecord
  has_many :detalle_datos_externos 
  validates_presence_of :nombre, :url_api,:token, message: ": este campo es obligatorio"
  validates :nombre, uniqueness: {case_sensitive: false, scope: :estado, message: "El nombre que intenta registrar ya existe" }

  def destroy
    update_attribute(:estado, 'I')
    self.detalle_datos_externos.update_all("estado = 'I'")
  end
end
