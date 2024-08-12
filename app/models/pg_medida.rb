class PgMedida < ApplicationRecord
  # rails generate model PgMedida --skip-migration --no-test-framework
  self.abstract_class = true
  establish_connection :oracle_development
  self.table_name = "parger.pg_medida"
  self.primary_key = :id_medida

  def codigo_desc_unidad_medida
    "#{self.id_medida} - #{self.descripcion}"
  end
end