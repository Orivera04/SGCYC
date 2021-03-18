class CreateBancos < ActiveRecord::Migration[6.0]
  def change
    create_table :bancos do |t|
      t.string :nombre
    end
  end
end
