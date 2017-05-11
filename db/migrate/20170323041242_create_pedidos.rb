class CreatePedidos < ActiveRecord::Migration[5.0]
  def change
    create_table :pedidos do |t|
      t.string :codigo
      t.integer :user_id

      t.timestamps
    end
  end
end
