class CreateTipoEntidads < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_entidads do |t|
      t.string :nombre
      t.timestamps
      t.references :socios, index: true
    end
  end
end
