# == Schema Information
#
# Table name: persona_empresa_formularios
#
#  id               :integer          not null, primary key
#  personas_area_id :integer          not null
#  opcion_ca_id     :integer          not null
#  descripcion      :string(255)
#  user_created_id  :integer
#  user_updated_id  :integer
#  estado           :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class PersonaEmpresaFormulario < ApplicationRecord
  belongs_to :personas_area
  belongs_to :opcion_ca
  validates_uniqueness_of :personas_area_id, :scope => :opcion_ca_id, :message => " error!! solo puede asignar una vez el permiso"
end
