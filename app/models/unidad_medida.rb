class UnidadMedida < ApplicationRecord
  validates_presence_of :empresa_id, :medida_id, :nombre, :estado, message: ": este campo es obligatorio"
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:empresa_id, :medida_id, :estado], message: "El dato que intenta registrar ya existe, Verifique!!!" }
end
