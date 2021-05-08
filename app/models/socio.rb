class Socio < ApplicationRecord
    belongs_to :sexo
    belongs_to :tipo_domicilio
    belongs_to :escolaridad
    belongs_to :estado_civil

    has_many :fiador, dependent: :destroy, inverse_of: :socio
    accepts_nested_attributes_for :fiador, allow_destroy: true

    validates :codigo_socio, presence: true
    validates :nombre, presence: true
    validates :apellido, presence: true
    validates :numero_cedula, presence: true
    validates :fecha_nacimiento, presence: true
    validates :sexo_id, presence: true
    validates :profesion, presence: true
    validates :estado_civil_id, presence: true
    validates :tipo_domicilio_id, presence: true
    validates :numero_telefono, presence: true
    validates :direccion_domiciliar, presence: true
    validates :empresa, presence: true
    validates :numero_inss, presence: true
    validates :salario_mensual, presence: true

    def display_name
        "#{nombre} #{apellido}"
    end

    def display_name_conyuge
        "#{nombre_conyuge} #{apellido_conyuge}"
    end

    def obtener_codigo_socio
        (codigo_socio.nil?) ? Socio.count + 1 : codigo_socio
    end

    def obtener_pagare_socio
        Pagare.where(socio_id: id)
    end
end
