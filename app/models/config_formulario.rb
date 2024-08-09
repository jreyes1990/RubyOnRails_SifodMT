class ConfigFormulario < ApplicationRecord
  belongs_to :tipo_formulario

  has_many :config_formulario_preguntas, dependent: :destroy

  accepts_nested_attributes_for :config_formulario_preguntas, reject_if: :all_blank, allow_destroy: true, update_only: true

  validates_presence_of :empresa_id, :area_id, :tipo_formulario_id, :nombre, :estado, message: ": este campo es obligatorio"
  validates :empresa_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :area_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :tipo_formulario_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :labor_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :tiene_app_siga, inclusion: { in: [true, false], message: "%{value} no es una opción válida, Verifique!!" }
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:empresa_id, :area_id, :tipo_formulario_id, :labor_id], message: "El dato que intenta registrar ya existe, Verifique!!!" }
end
