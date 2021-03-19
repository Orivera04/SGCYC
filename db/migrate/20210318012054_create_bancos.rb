class CreateBancos < ActiveRecord::Migration[6.0]
  def change
    create_table :bancos do |t|
      t.string :nombre
      t.string :siglas
    end
  end
end
