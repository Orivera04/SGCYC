class Cargo < ApplicationRecord
    validates :nombre, presence: true
    validates :descripcion, presence: true
    validates_length_of :nombre, minimum: 1, maximum: 255
end
