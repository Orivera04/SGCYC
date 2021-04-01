class CreateTasaCambios < ActiveRecord::Migration[6.0]
  def change
    create_table :tasa_cambios do |t|
      t.decimal :tasa_cambio, precision: 10, scale: 2
      t.date :fecha
    end
  end
end
