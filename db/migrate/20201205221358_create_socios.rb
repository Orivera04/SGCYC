class CreateSocios < ActiveRecord::Migration[6.0]
  def change
    create_table :socios do |t|
      t.string :codigo_socio
      t.string :nombre
      t.string :apellido
      t.string :numero_cedula
      t.date :fecha_nacimiento
      t.timestamps
    end
  end
end
