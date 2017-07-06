class AddTotalToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :total, :integer
  end
end
