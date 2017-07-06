class AddColorToProductosAPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :productos_a_pedidos, :color, :string
    add_column :productos_a_pedidos, :offer, :integer
  end
end
