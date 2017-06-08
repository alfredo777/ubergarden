class ChangeColumnTotalInPedido < ActiveRecord::Migration[5.0]
  def change
  	change_column :pedidos, :total, :float
  end
end
