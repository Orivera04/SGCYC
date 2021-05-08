class CreateTipoPagos < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_pagos do |t|
      t.string :nombre
    end
  end
end
