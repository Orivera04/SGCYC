class AddFieldsToUsuario < ActiveRecord::Migration[6.0]
  def change
    add_reference :usuarios, :roles, index: true
    add_reference :usuarios, :posicions, index: true
    add_column :usuarios, :nombre, :string
    add_column :usuarios, :estado, :boolean
  end
end
