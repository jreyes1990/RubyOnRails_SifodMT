class PgArea < ApplicationRecord
  # rails generate model PgArea --skip-migration --no-test-framework
  self.abstract_class = true
  establish_connection :oracle_development
  self.table_name = "parger.pg_area"
  self.primary_keys = :id_empresa, :id_area

  belongs_to :pg_empresa, foreign_key: :id_empresa

  def codigo_descripcion_area
    "#{self.id_area} - #{self.descripcion}"
  end
end