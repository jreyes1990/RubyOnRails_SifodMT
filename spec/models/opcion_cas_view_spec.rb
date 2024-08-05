# == Schema Information
#
# Table name: opcion_cas_views
#
#  id          :integer          not null, primary key
#  opcion      :string(255)
#  componente  :string(255)
#  atributo    :string(255)
#  descripcion :string(255)
#  estado      :string(255)
#
require 'rails_helper'

RSpec.describe OpcionCasView, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
