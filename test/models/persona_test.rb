# == Schema Information
#
# Table name: personas
#
#  id              :integer          not null, primary key
#  foto            :string(255)
#  nombre          :string(255)
#  apellido        :string(255)
#  direccion       :string(255)
#  telefono        :integer
#  token           :string(1000)
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
