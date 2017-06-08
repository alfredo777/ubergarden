class AddCpostalToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :cpostal, :integer
  end
end
