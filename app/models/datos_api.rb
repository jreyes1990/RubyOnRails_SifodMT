# == Schema Information
#
# Table name: datos_apis
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
class DatosApi < ApplicationRecord
  has_many :detalle_datos_apis 
  def destroy
    update_attribute(:estado, 'I')
    self.detalle_datos_apis.update_all("estado = 'I'")
  end
end
