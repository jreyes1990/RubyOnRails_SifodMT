class SgiEmpresa < ApplicationRecord
  # rails generate model SgiEmpresa --skip-migration --no-test-framework
  self.abstract_class = true
  establish_connection :oracle_development
  self.table_name = "sig.empresas"
  self.primary_key = :id
end