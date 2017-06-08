class AddEmailToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :email, :string
    add_column :pedidos, :email2, :string
  end
end
