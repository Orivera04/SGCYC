class ChangeSocioAtributes < ActiveRecord::Migration[6.0]
  def change
    add_reference :socios, :sexos, index: true, foreign_key: true
    add_reference :socios, :escolaridads, index: true, foreign_key: true
    add_column :socios, :profesion, :string
    add_reference :socios, :estado_civils, index: true, foreign_key: true
    add_column :socios, :anios_relacion, :integer
    add_column :socios, :numero_dependiente, :integer
    add_reference :socios, :tipo_domicilios, index: true, foreign_key: true
    add_column :socios, :numero_telefono, :string
    add_column :socios, :direccion_domiciliar, :string
    add_column :socios, :municipio, :string
    add_column :socios, :departamento, :string
    add_column :socios, :empresa, :string
    add_column :socios, :numero_inss, :string
    add_column :socios, :direccion_empresa, :string
    add_column :socios, :departamento_empresa, :string
    add_column :socios, :municipio_empresa, :string
    add_column :socios, :numero_telefono_empresa, :string
    add_column :socios, :tiempo_laborar, :integer
    add_column :socios, :cargo, :string
    add_column :socios, :salario_mensual, :integer
    add_column :socios, :forma_pago, :string
  end
end
