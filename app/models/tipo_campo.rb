class TipoCampo < ApplicationRecord
  belongs_to :tipo_seleccion, optional: true
  belongs_to :tipo_contenido, optional: true
end
