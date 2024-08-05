# == Schema Information
#
# Table name: opciones
#
#  id              :integer          not null, primary key
#  nombre          :string(255)
#  descripcion     :string(255)
#  icono           :string(255)
#  path            :string(255)
#  controlador     :string(255)
#  menu_id         :integer          not null
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class OpcionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
