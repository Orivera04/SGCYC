class CreateCargos < ActiveRecord::Migration[6.0]
  def change
    create_table :cargos do |t|
      t.string :nombre
      t.timestamps
    end
  end
end
