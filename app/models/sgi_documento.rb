class SgiDocumento < ApplicationRecord
  # rails generate model SgiDocumento --skip-migration --no-test-framework
  self.abstract_class = true
  establish_connection :oracle_development
  self.table_name = "sig.documentos"
  self.primary_key = :id

  def codigo_descripcion_documento
    "#{self.codigo}#{self.correlativo} - #{self.nombre.upcase}"
  end
end