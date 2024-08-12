class PgLabor < ApplicationRecord
  # rails generate model PgLabor --skip-migration --no-test-framework
  self.abstract_class = true
  establish_connection :oracle_development
  self.table_name = "parger.pg_labor"
  self.primary_keys = :id_empresa, :id_area, :id_labor

  def codigo_descripcion_labor
    "#{self.id_labor} - #{self.descripcion}"
  end
end
