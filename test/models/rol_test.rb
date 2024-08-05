# == Schema Information
#
# Table name: roles
#
#  id              :integer          not null, primary key
#  nombre          :string(255)
#  descripcion     :string(255)
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class RolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
