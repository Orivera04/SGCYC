class CreateSexos < ActiveRecord::Migration[6.0]
  def change
    create_table :sexos do |t|
      t.string :nombre
    end
  end
end
