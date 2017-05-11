class AddPaisDeProcedenciaToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :pais_de_procedencia, :string
    add_column :products, :region_climatica, :string
    add_column :products, :familia, :string
    add_column :products, :orden, :string
    add_column :products, :categoria_principal_interna, :string
  end
end
