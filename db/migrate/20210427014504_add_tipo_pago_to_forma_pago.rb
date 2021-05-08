class AddTipoPagoToFormaPago < ActiveRecord::Migration[6.0]
  def change
    add_reference :forma_pagos, :tipo_pago, index: true, foreign_key: true
    add_column :forma_pagos, :equivalencia, :decimal
  end
end