# == Schema Information
#
# Table name: bitacora_consulta_movils
#
#  id          :integer          not null, primary key
#  persona_id  :integer          not null
#  email       :string(255)
#  accion      :string(255)
#  descripcion :string(255)
#  fecha       :string(255)
#  hora        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class BitacoraConsultaMovil < ApplicationRecord
  belongs_to :persona
end
