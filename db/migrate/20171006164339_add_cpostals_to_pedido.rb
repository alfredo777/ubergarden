class AddCpostalsToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :cpostals, :string
  end
end
