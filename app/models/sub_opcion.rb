class SubOpcion < ApplicationRecord
  has_many :opciones

  validates_presence_of :nombre, :estado, message: ": este campo es obligatorio"
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :visible_sidebar, inclusion: { in: [true, false], message: "%{value} no es una opción válida, Verifique!!" }
  validates :posicion, numericality: { only_integer: true, greater_than: 0, message: ": debe ser un número entero mayor a 0." }
  validates :nombre, uniqueness: {case_sensitive: false, scope: :estado, message: "El nombre que intenta registrar ya existe" }
end
