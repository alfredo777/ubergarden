class AddSessionTokenToProductosAPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :productos_a_pedidos, :session_token, :string
  end
end
