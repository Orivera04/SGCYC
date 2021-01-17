class CreateTasaCambios < ActiveRecord::Migration[6.0]
  def change
    create_table :tasa_cambios do |t|
      t.datetime :fecha
      t.string :dolar
      t.string :cordoba
      t.timestamps
    end
  end
end
