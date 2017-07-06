class AddCantidadProductosAPedido < ActiveRecord::Migration[5.0]
  def change
  	add_column :productos_a_pedidos, :price, :float
  	add_column :productos_a_pedidos, :total_price, :float
  	add_column :productos_a_pedidos, :quanty, :integer
  end
end
