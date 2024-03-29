class Banco < ApplicationRecord
    validates :nombre, presence: true
    validates :siglas, presence: true
    validates_length_of :nombre, minimum: 1, maximum: 255
    validates_length_of :siglas, minimum: 1, maximum: 10

    def self.ransackable_attributes(auth_object = nil)
        ["id", "nombre", "siglas"]
    end
end
