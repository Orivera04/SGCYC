class CreateRolAccions < ActiveRecord::Migration[6.0]
  def change
    create_table :rol_accions do |t|
      t.references :rol, index: true, foreign_key: true
      t.references :recurso, index: true, foreign_key: true
      t.references :accion, index: true, foreign_key: true
      t.timestamps
    end
  end
end
