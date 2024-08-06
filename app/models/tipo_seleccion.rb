class TipoSeleccion < ApplicationRecord
  has_many :tipo_campos
  
  validates_presence_of :nombre, :estado, message: ": este campo es obligatorio"
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:estado], message: "El dato que intenta registrar ya existe, Verifique!!!" }
end
