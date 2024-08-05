# == Schema Information
#
# Table name: detalle_datos_externos
#
#  id               :integer          not null, primary key
#  datos_externo_id :integer          not null
#  nombre           :string(255)
#  param1           :string(255)
#  param2           :string(255)
#  param3           :string(255)
#  param4           :string(255)
#  param5           :string(255)
#  tipo             :string(255)
#  body             :string(255)
#  estado           :string(255)
#  user_created_id  :integer
#  user_updated_id  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'test_helper'

class DetalleDatosExternoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
