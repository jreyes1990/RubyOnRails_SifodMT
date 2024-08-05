# == Schema Information
#
# Table name: datos_externos
#
#  id              :integer          not null, primary key
#  nombre          :string(255)
#  url_api         :string(255)
#  token           :string(255)
#  estado          :string(255)
#  user_created_id :integer
#  user_updated_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class DatosExternoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
