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
class OpcionCasView < ApplicationRecord
    self.table_name = "opcion_cas_views"
    self.primary_key = :id

    def readonly?
        true
    end
end
