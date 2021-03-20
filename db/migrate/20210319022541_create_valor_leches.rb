class CreateValorLeches < ActiveRecord::Migration[6.0]
  def change
    create_table :valor_leches do |t|
      t.decimal :tasa_cambio, precision: 10, scale: 2
      t.date :fecha
    end
  end
end
