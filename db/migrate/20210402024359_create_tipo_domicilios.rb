class CreateTipoDomicilios < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_domicilios do |t|
      t.string :nombre
    end
  end
end
