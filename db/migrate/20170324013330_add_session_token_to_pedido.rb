class AddSessionTokenToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :session_token, :string
  end
end
