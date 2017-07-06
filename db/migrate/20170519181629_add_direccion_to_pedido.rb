class AddDireccionToPedido < ActiveRecord::Migration[5.0]
  def change
  	add_column :pedidos, :nombre_persona_que_ordena, :string
    add_column :pedidos, :apellidos_persona_que_ordena, :string
    add_column :pedidos, :persona_autorizada_a_recoger_1, :string
    add_column :pedidos, :persona_autorizada_a_recoger_2, :string
    add_column :pedidos, :persona_autorizada_a_recoger_3, :string
    add_column :pedidos, :persona_autorizada_a_recoger_4, :string
    add_column :pedidos, :telefono_fijo, :string
    add_column :pedidos, :telefono_oficina, :string
    add_column :pedidos, :telefono_celular, :string
    add_column :pedidos, :direccion, :text
    add_column :pedidos, :calle, :string
    add_column :pedidos, :numero_interior, :string
    add_column :pedidos, :numero_exterior, :string
    add_column :pedidos, :colonia, :string
    add_column :pedidos, :localidad, :string
    add_column :pedidos, :estado, :string
    add_column :pedidos, :pais, :string
    add_column :pedidos, :metodo_de_pago, :string
    add_column :pedidos, :anonimo, :boolean, default: false
    add_column :pedidos, :metodo_de_envio, :string
    add_column :pedidos, :costo_de_envio, :float
    add_column :pedidos, :monto_total_del_pedido, :float
    add_column :pedidos, :cuantificador, :text
    add_column :pedidos, :estatus_del_pedido, :string
    add_column :pedidos, :activacion_de_pedido, :boolean, default: false
    add_column :pedidos, :finalizacion_de_pedido, :boolean, default: false
  end
end
