class CreateSocios < ActiveRecord::Migration[6.0]
  def change
    create_table :socios do |t|
      t.string :codigo_socio
      t.string :nombre
      t.string :apellido
      t.string :numero_cedula
      t.string :numero_ruc
      t.string :direccion
      t.integer :telefono
      t.string :correo
      t.boolean :estado
      t.timestamps
    end
  end
end
