class Pedido < ApplicationRecord
	has_many :productos_a_pedidos
end
