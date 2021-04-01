class AddFieldsToUsuario < ActiveRecord::Migration[6.0]
  def change
    add_reference :usuarios, :roles, index: true
    add_reference :usuarios, :cargos, index: true
    add_column :usuarios, :nombre, :string
    add_column :usuarios, :activo, :boolean
  end
end
