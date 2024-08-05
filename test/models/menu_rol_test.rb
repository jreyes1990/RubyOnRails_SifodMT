# == Schema Information
#
# Table name: menu_roles
#
#  id              :integer          not null, primary key
#  rol_id          :integer          not null
#  opcion_id       :integer          not null
#  menu_padre      :integer
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class MenuRolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
