class CreatePlazos < ActiveRecord::Migration[6.0]
  def change
    create_table :plazos do |t|
      t.string :nombre
      t.integer :plazo
    end
  end
end
