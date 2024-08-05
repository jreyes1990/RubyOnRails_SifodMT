# == Schema Information
#
# Table name: opcion_cas
#
#  id              :integer          not null, primary key
#  opcion_id       :integer          not null
#  componente_id   :integer          not null
#  atributo_id     :integer          not null
#  descripcion     :string(255)
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class OpcionCaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
