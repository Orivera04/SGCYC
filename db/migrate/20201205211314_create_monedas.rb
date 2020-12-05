class CreateMonedas < ActiveRecord::Migration[6.0]
  def change
    create_table :monedas do |t|
      t.string :simbolo_moneda
      t.string :nombre_moneda
      t.timestamps
    end
    /SystemSetting.create :simbolo_moneda => "C$", :nombre_moneda => "NIO"/
  end
end
