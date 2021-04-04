class CreateAntecedenteCrediticios < ActiveRecord::Migration[6.0]
  def change
    create_table :antecedente_crediticios do |t|
      t.references :pagare, index: true, foreign_key: true
      t.string :institucion
      t.date :fecha
      t.decimal :monto, precision: 10, scale: 2
      t.decimal :saldo, precision: 10, scale: 2
    end
  end
end
