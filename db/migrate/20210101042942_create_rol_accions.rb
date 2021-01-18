class CreateRolAccions < ActiveRecord::Migration[6.0]
  def change
    create_table :rol_accions do |t|
      t.references :rols, index: true, foreign_key: true
      t.references :recursos, index: true, foreign_key: true
      t.references :accion, index: true, foreign_key: true
      t.timestamps
    end
  end
end
