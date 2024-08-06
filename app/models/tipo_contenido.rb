class TipoContenido < ApplicationRecord
  has_many :tipo_campos
  
  validates_presence_of :nombre, :content_type, :estado, message: ": este campo es obligatorio"
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :content_type, uniqueness: {case_sensitive: false, scope: [:content_type, :estado], message: "El dato que intenta registrar ya existe, Verifique!!!" }
end