class ChangeSocioAtributes < ActiveRecord::Migration[6.0]
  def change
    add_reference :socios, :sexo, index: true, foreign_key: true
    add_reference :socios, :escolaridad, index: true, foreign_key: true
    add_column :socios, :profesion, :string
    add_reference :socios, :estado_civil, index: true, foreign_key: true
    add_column :socios, :anios_relacion, :integer
    add_column :socios, :numero_dependiente, :integer
    add_reference :socios, :tipo_domicilio, index: true, foreign_key: true
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
    add_column :socios, :nombre_conyuge, :string
    add_column :socios, :apellido_conyuge, :string
    add_column :socios, :numero_cedula_conyuge, :string
    add_column :socios, :fecha_nacimiento_conyuge, :date
    add_column :socios, :ocupacion_conyuge, :string
    add_column :socios, :telefono_conyuge, :string
    add_column :socios, :lugar_trabajo_conyuge, :string
    add_column :socios, :tiempo_laborar_conyuge, :integer
    add_column :socios, :direccion_domicilio_conyuge, :string
    add_column :socios, :sexo_id_conyuge, :integer
  end
end
