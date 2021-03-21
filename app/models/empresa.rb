class Empresa < ApplicationRecord
    validates :nombre_comercial, presence: true
    validates :numero_telefono, presence: true
    validates :correo, presence: true
    validates :actividad_comercial, presence: true
    validates :numero_ruc, presence: true
    validates :direccion, presence: true
    validates_length_of :nombre_comercial, minimum: 1, maximum: 255
    validates_length_of :numero_telefono, minimum: 1, maximum: 20
    validates_length_of :correo, minimum: 1, maximum: 50
    validates_length_of :actividad_comercial, minimum: 1, maximum: 255
    validates_length_of :numero_ruc, minimum: 1, maximum: 15
    validates_length_of :direccion, minimum: 1, maximum: 255
    validates_format_of :correo, :with => Devise::email_regexp
end
