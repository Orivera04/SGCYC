class CreateClientes < ActiveRecord::Migration[6.0]
  def change
    create_table :clientes do |t|
      t.string :codigo_cliente
      t.string :tipo_entidad_id
      t.string :nombre
      t.string :apellido
      t.string :numero_cedula
      t.string :numero_ruc
      t.string :direccion
      t.integer :telefono
      t.string :correo
      t.boolean :activo
      t.timestamps
    end
  end
end
