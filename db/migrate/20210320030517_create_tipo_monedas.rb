class CreateTipoMonedas < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_monedas do |t|
      t.string :nombre
      t.string :simbolo
      t.timestamps
    end
  end
end
