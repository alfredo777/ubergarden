class AddConektaCustomerToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :conekta_customer, :string
    add_column :pedidos, :conekta_order, :string
  end
end
