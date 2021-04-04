class CreateReferenciaPersonalPagares < ActiveRecord::Migration[6.0]
  def change
    create_table :referencia_personal_pagares do |t|
      t.references :pagare, index: true, foreign_key: true
      t.string :nombre
      t.string :domicilio
      t.string :telefono
    end
  end
end
