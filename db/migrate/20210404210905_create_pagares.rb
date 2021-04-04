class CreatePagares < ActiveRecord::Migration[6.0]
  def change
    create_table :pagares do |t|
      t.references :usuario, index: true, foreign_key: true
      t.references :socio, index: true, foreign_key: true
      t.references :tipo_moneda, index: true, foreign_key: true
      t.integer :numero_pagare
      t.decimal :cantidad_solicitada, precision: 10, scale: 2
      t.references :plazo, index: true, foreign_key: true
      t.references :interes, index: true, foreign_key: true
      t.string :forma_pago
      t.decimal :cuota_pagar, precision: 10, scale: 2
      t.string :destino_credito
      t.string :ubicacion_inversion
      t.string :garantias_ofrecidas
      t.boolean :aceptar_condiciones_diferentes
      t.boolean :tuvo_credito
      t.boolean :tiene_credito_actualmente
      t.string :garantia_hipotecaria
      t.integer :cantidad_leche_entregada
      t.string :observaciones
      t.timestamps
    end
  end
end
