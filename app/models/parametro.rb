# == Schema Information
#
# Table name: parametros
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  view_default        :string(255)
#  area_id             :integer
#  nombre_area         :string(255)
#  empresa_id          :integer
#  nombre_empresa      :string(255)
#  ruta_predeterminada :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Parametro < ApplicationRecord
  belongs_to :user
  belongs_to :area
end
