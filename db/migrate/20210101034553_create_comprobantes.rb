class CreateComprobantes < ActiveRecord::Migration[6.0]
  def change
    create_table :comprobantes do |t|

      t.timestamps
    end
  end
end
