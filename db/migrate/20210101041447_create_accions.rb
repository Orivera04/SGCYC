class CreateAccions < ActiveRecord::Migration[6.0]
  def change
    create_table :accions do |t|
      t.string :nombre
      t.string :descripcion
      t.timestamps
    end
  end
end
