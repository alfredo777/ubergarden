class AddAcceptTermsToPedido < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :aceptacion_de_terminos, :boolean, default: false
  end
end
