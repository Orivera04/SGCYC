class Usuario < ApplicationRecord
  ACTIVO = 1
  INACTIVO = 0
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nombre, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["activo", "cargos_id", "created_at", "email", "encrypted_password", "id", "nombre", "remember_created_at", "reset_password_sent_at", "reset_password_token", "rols_id", "updated_at"]
  end

  def active_for_authentication?
    super && self.activo
  end

  def inactive_message
    "Tu cuenta ha sido desactivada."
  end
end
