class AddFieldsToUsuario < ActiveRecord::Migration[6.0]
  def change
    add_column :usuarios, :nombre, :string
    add_column :usuarios, :activo, :boolean
  end
end
