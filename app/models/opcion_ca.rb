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
class OpcionCa < ApplicationRecord
  belongs_to :opcion
  belongs_to :componente
  belongs_to :atributo

  validates_presence_of :opcion_id, :componente_id, :atributo_id, :descripcion, message: ": este campo es obligatorio"
  validates_uniqueness_of :opcion_id, :scope => [:componente_id, :atributo_id], :message => " error!! solo puede asignar una vez el componente y el atributo al formulario"
  
end
