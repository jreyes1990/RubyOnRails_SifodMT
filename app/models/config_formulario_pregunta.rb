class ConfigFormularioPregunta < ApplicationRecord
  belongs_to :config_formulario
  belongs_to :config_pregunta
  belongs_to :config_sub_pregunta, optional: true
  belongs_to :unidad_medida, optional: true

  validates_presence_of :empresa_id, :area_id, :config_formulario_id, :config_pregunta_id, :estado, message: ": este campo es obligatorio"
  validates :empresa_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :area_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :config_formulario_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :config_pregunta_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :config_sub_pregunta_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :unidad_medida_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :posicion, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :requerido, inclusion: { in: [true, false], message: "%{value} no es una opción válida, Verifique!!" }
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :config_pregunta_id, uniqueness: {case_sensitive: false, scope: [:empresa_id, :area_id, :config_formulario_id, :config_sub_pregunta_id, :unidad_medida_id], message: "El dato que intenta registrar ya existe, Verifique!!!" }

  def destroy
    self.update_attribute(:estado, "I") # Cambia 'eliminado' por el estado deseado
    # self.update_column(:estado, "I") # Cambia 'eliminado' por el estado deseado
  end
end
