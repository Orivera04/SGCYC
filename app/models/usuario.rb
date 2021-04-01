class Usuario < ApplicationRecord
  ACTIVO = 1
  INACTIVO = 0
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nombre, presence: true

  def active_for_authentication?
    super && self.activo
  end

  def inactive_message
    "Tu cuenta ha sido desactivada."
  end
end
