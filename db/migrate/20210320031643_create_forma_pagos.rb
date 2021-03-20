class CreateFormaPagos < ActiveRecord::Migration[6.0]
  def change
    create_table :forma_pagos do |t|
      t.string :nombre
      t.references :tipo_moneda, index: true
    end
  end
end
