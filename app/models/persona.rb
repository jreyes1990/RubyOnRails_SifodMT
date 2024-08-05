# == Schema Information
#
# Table name: personas
#
#  id              :integer          not null, primary key
#  foto            :string(255)
#  nombre          :string(255)
#  apellido        :string(255)
#  direccion       :string(255)
#  telefono        :integer
#  token           :string(1000)
#  user_created_id :integer
#  user_updated_id :integer
#  estado          :string(255)
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Persona < ApplicationRecord
  # mount_uploader :foto, FotoUploader
  belongs_to :user
  has_many :personas_areas
  validates :nombre, :apellido, :direccion, :telefono, presence: false

  def nombre_completo
    "#{self.nombre} #{self.apellido}"
  end

  def nombre_completo_con_email
    "#{self.nombre} #{self.apellido} - #{self.user.email}"
  end
end
