# == Schema Information
#
# Table name: detalle_datos_apis
#
#  id              :integer          not null, primary key
#  datos_api_id    :integer          not null
#  nombre          :string(255)
#  param1          :string(255)
#  param2          :string(255)
#  param3          :string(255)
#  param4          :string(255)
#  param5          :string(255)
#  tipo            :string(255)
#  body            :string(255)
#  estado          :string(255)
#  user_created_id :integer
#  user_updated_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class DetalleDatosApi < ApplicationRecord
  belongs_to :datos_api
end
