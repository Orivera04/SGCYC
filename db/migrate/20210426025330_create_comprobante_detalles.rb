class CreateComprobanteDetalles < ActiveRecord::Migration[6.0]
  def change
    create_table :comprobante_detalles do |t|
      t.references :comprobante, index: true, foreign_key: true
      t.references :forma_pago, index: true, foreign_key: true
      t.decimal :monto_pagado, precision: 10, scale: 2
      t.string :referencia
      t.timestamps
    end
  end
end