class CreateRols < ActiveRecord::Migration[6.0]
  def change
    create_table :rols do |t|
      t.string :nombre
      t.boolean :estado
      t.timestamps
    end
  end
end
