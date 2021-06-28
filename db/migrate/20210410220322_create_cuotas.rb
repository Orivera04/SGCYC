class CreateCuotas < ActiveRecord::Migration[6.0]
  def change
    create_table :cuotas do |t|
      t.references :pagare, index: true, foreign_key: true
      t.date :fecha_pago
      t.integer :numero_cuota
      t.decimal :cuota, precision: 10, scale: 2
      t.decimal :mora, precision: 10, scale: 2
      t.decimal :monto_abonado, precision: 10, scale: 2
      t.boolean :cancelado
    end
  end
end
