# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  user_created_id        :integer
#  user_updated_id        :integer
#  estado                 :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :password_expirable, :password_archivable, :trackable

  has_one :persona, dependent: :destroy
  # after_create :set_persona

  # def set_persona(create_persona = true)
  #   self.persona = Persona.create() if create_persona
  # end

  def active_for_authentication?
    if self.estado == 'I'
      super && false
    else
      super && true
    end
  end


end
