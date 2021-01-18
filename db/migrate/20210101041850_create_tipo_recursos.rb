class CreateTipoRecursos < ActiveRecord::Migration[6.0]
  def change
    create_table :tipo_recursos do |t|
      t.string :nombre
      t.timestamps
    end
  end
end
