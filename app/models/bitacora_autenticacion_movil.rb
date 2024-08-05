# == Schema Information
#
# Table name: bitacora_autenticacion_movils
#
#  id          :integer          not null, primary key
#  persona_id  :integer
#  email       :string(255)
#  accion      :string(255)
#  descripcion :string(255)
#  fecha       :string(255)
#  hora        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class BitacoraAutenticacionMovil < ApplicationRecord
end
