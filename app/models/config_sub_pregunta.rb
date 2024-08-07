class ConfigSubPregunta < ApplicationRecord
  validates_presence_of :empresa_id, :area_id, :nombre, :estado, message: ": este campo es obligatorio"
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :empresa_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :area_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:empresa_id, :area_id, :estado], message: "El dato que intenta registrar ya existe, Verifique!!!" }
end
