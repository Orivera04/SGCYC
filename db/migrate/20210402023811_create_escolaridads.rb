class CreateEscolaridads < ActiveRecord::Migration[6.0]
  def change
    create_table :escolaridads do |t|
      t.string :nombre
    end
  end
end
