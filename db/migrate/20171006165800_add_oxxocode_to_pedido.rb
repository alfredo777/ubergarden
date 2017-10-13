class AddOxxocodeToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :oxxocode, :string
  end
end
