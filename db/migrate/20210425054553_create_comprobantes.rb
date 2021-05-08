class CreateComprobantes < ActiveRecord::Migration[6.0]
  def change
    create_table :comprobantes do |t|
      t.integer :numero_comprobante
      t.references :pagare, index: true, foreign_key: true
      t.references :usuario, index: true, foreign_key: true
      t.references :socio, index: true, foreign_key: true
      t.references :tipo_moneda, index: true, foreign_key: true
      t.decimal :monto_pagado, precision: 10, scale: 2
      t.string :observacion
      t.timestamps
    end
  end
end
