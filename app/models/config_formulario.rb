class ConfigFormulario < ApplicationRecord
  belongs_to :tipo_formulario

  has_many :config_formulario_preguntas, dependent: :destroy

  accepts_nested_attributes_for :config_formulario_preguntas, reject_if: :all_blank, allow_destroy: true, update_only: true

  validates_presence_of :empresa_id, :area_id, :tipo_formulario_id, :nombre, :estado, message: ": este campo es obligatorio"
  validates :empresa_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :area_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :tipo_formulario_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :labor_id, numericality: { only_integer: true, message: ": debe ser un número entero." }, allow_nil: true
  validates :nombre, presence: true, length: { maximum: 100 }
  validates :tiene_app_siga, inclusion: { in: [true, false], message: "%{value} no es una opción válida, Verifique!!" }
  validates :estado, inclusion: { in: %w(A I), message: "%{value} no es una opción válida, Verifique!!" }
  validates :nombre, uniqueness: {case_sensitive: false, scope: [:empresa_id, :area_id, :tipo_formulario_id, :labor_id], message: "El dato que intenta registrar ya existe, Verifique!!!" }

  # Validaciones personalizadas
  validate :nombre_length_validation
  validate :custom_uniqueness_validation

  before_save :assign_values_to_config_formulario_preguntas

  def custom_uniqueness_validation
    error_messages = []
    config_formulario_preguntas.each do |config_formulario_pregunta|
      unless config_formulario_pregunta.valid?
        config_formulario_pregunta.errors.full_messages.each do |msg|
          error_messages << msg unless error_messages.include?(msg)
        end
      end
    end
    errors.add(:base, error_messages.uniq.join(", ")) unless error_messages.empty?
  end

  private
    def nombre_length_validation
      return if nombre.blank?

      if nombre.present? && nombre.length < 5
        errors.add(:nombre, ": es demasiado corto (mínimo son 5 caracteres)")
      elsif nombre.present? && nombre.length > 100
        errors.add(:nombre, ": es demasiado largo (máximo son 100 caracteres)")
      end
    end

    def assign_values_to_config_formulario_preguntas
      self.config_formulario_preguntas.each do |config_formulario_pregunta|
        if config_formulario_pregunta.new_record?  # Verifica si el registro es nuevo
          config_formulario_pregunta.empresa_id = self.empresa_id
          config_formulario_pregunta.area_id = self.area_id
          config_formulario_pregunta.estado = self.estado
          config_formulario_pregunta.user_created_id = self.user_created_id
          config_formulario_pregunta.usr_grab = self.usr_grab
        end
        # Siempre actualiza user_updated_id independientemente si es nuevo o no
        config_formulario_pregunta.user_updated_id = self.user_updated_id
        config_formulario_pregunta.usr_modi = self.usr_modi
      end
    end
end
