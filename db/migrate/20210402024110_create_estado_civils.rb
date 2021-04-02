class CreateEstadoCivils < ActiveRecord::Migration[6.0]
  def change
    create_table :estado_civils do |t|
      t.string :nombre
    end
  end
end
