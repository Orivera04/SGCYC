class Cargo < ApplicationRecord
    validates :nombre, presence: true
    validates :descripcion, presence: true
    validates_length_of :nombre, minimum: 1, maximum: 255

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "descripcion", "id", "nombre", "updated_at"]
    end
end
