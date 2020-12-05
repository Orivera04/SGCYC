class CreateTipoPagos < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_pagos do |t|
      t.string :nombre
      t.timestamps
      t.references :monedas
    end
  end
end
