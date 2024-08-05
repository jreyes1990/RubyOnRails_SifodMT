# == Schema Information
#
# Table name: bitacora_token_personas
#
#  id          :integer          not null, primary key
#  persona_id  :integer          not null
#  accion      :string(255)
#  descripcion :string(255)
#  fecha       :string(255)
#  hora        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class BitacoraTokenPersona < ApplicationRecord
  belongs_to :persona
end
