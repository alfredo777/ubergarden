class CreateProductosAPedidos < ActiveRecord::Migration[5.0]
  def change
    create_table :productos_a_pedidos do |t|
      t.integer :product_id
      t.integer :pedido_id

      t.timestamps
    end
  end
end
