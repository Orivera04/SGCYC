class CreateFiadors < ActiveRecord::Migration[6.0]
  def change
    create_table :fiadors do |t|
      t.references :socio, index: true, foreign_key: true
      t.string :nombre
      t.string :apellido
      t.string :numero_cedula
      t.string :domicilio
      t.string :municipio
      t.references :estado_civils, index: true, foreign_key: true
      t.string :nombre_conyuge
      t.string :profesion
      t.string :lugar_trabajo
      t.string :direccion_domicilio
      t.string :telefono
      t.integer :tiempo_laborar
      t.integer :salario_mensual
      t.integer :egreso_mensual
      t.string :disponibilidad_al_mes
      t.string :tiempo_conocer_solicitante
      t.string :anio_parentesco
    end
  end
end
