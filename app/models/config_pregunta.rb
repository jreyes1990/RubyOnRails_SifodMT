class ConfigPregunta < ApplicationRecord
  belongs_to :tipo_campo

  validates_presence_of :empresa_id, :area_id, :tipo_campo_id, :nombre, :estado, message: ": este campo es obligatorio"
  validates :empresa_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :area_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :tipo_campo_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :tiene_parametro, inclusion: { in: [true, false], message: "%{value} no es una opción válida, Verifique!!" }
  validates :tiene_sub_pregunta, inclusion: { in: [true, false], message: "%{value} no es una opción válida, Verifique!!" }
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:empresa_id, :area_id, :tipo_campo_id, :estado], message: "El dato que intenta registrar ya existe, Verifique!!!" }
end
