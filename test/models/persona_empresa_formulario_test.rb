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
require 'test_helper'

class PersonaEmpresaFormularioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
