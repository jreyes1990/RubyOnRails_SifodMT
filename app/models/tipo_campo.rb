class TipoCampo < ApplicationRecord
  belongs_to :tipo_seleccion, optional: true
  belongs_to :tipo_contenido, optional: true

  validates_presence_of :nombre, :tipo_dato, :estado, message: ": este campo es obligatorio"
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :tiene_respuesta, inclusion: { in: [true, false], message: "%{value} no es una opción válida, Verifique!!" }
  validates :tipo_seleccion_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :tipo_contenido_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :tipo_dato, uniqueness: {case_sensitive: false, scope: [:tipo_seleccion_id, :tipo_contenido_id, :estado], message: "El dato que intenta registrar ya existe" }
end
