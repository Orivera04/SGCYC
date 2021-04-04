class CreateInteres < ActiveRecord::Migration[6.0]
  def change
    create_table :interes do |t|
      t.string :cantidad
    end
  end
end
