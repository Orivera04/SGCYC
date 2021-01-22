class CreateEmpresas < ActiveRecord::Migration[6.0]
  def change
    create_table :empresas do |t|
      t.string :nombre_comercial
      t.integer :numero_telefono
      t.string :correo
      t.string :direccion
      t.string :actividad_comercial
      t.string :numero_ruc
      t.text :logo_imagen, limit: 4294967295
      t.timestamps
    end
  end
end
