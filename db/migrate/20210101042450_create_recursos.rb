class CreateRecursos < ActiveRecord::Migration[6.0]
  def change
    create_table :recursos do |t|
      t.string :nombre
      t.string :descripcion
      t.references :tipo_recurso, index: true, foreign_key: true
      t.timestamps
    end
  end
end
