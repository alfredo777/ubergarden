class AddCustomerRegisterIdToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :customer_register_id, :integer
  end
end
