class CreateConyuges < ActiveRecord::Migration[6.0]
  def change
    create_table :conyuges do |t|
      t.references :socios, index: true, foreign_key: true
      t.string :nombre
      t.string :apellido
      t.string :numero_cedula
      t.date :fecha_nacimiento
      t.references :sexos, index: true, foreign_key: true
      t.string :ocupacion
      t.string :telefono
      t.string :lugar_trabajo
      t.integer :tiempo_laborar
      t.string :direccion_domicilio
    end
  end
end
